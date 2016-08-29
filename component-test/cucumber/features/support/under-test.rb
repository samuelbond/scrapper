require 'singleton'
require 'process-helper'

class UnderTest
  include Singleton

  def self.start
    STDOUT.puts "(re)starting process under test..."
    stop
    @process = ProcessHelper::ProcessHelper.new({:print_lines => false})
    args = ["python #{BASE_DIR}/bin/scrapper "]
    @process.start(args, /(Starting Scrapper)/, 250)

    out = @process.get_log(:out).to_s
    err = @process.get_log(:err).to_s
    @startup_log = out + err

    if @startup_log.match /(raise|error)/
      STDERR.puts @startup_log
      stop
      raise "Startup error detected - aborting"
    end
  end

  def self.process
    @process
  end

  def self.stop
    if !@process.nil?
      @process.kill
      @process.wait_for_exit
    end
    @process = nil
  end

  def self.get_out
    @process.get_log(:out)
  end

  def self.get_err
    @process.get_log(:err)
  end

  def self.base_url
    if ENV["BASE_URL"]
      return ENV["BASE_URL"]
    elsif !@process
      raise "BASE_URL not set but NO_START_UNDERTEST is"
    else
      m = @startup_log.match /\b0\.0\.0\.0:(\d+)\b/
      if m
        return "http://localhost:#{m[1]}"
      else
        raise "Can't determine own URL and BASE_URL not set"
      end
    end
  end

  def self.last_log(max_lines = 0)
    return ["(Process under test not managed by Cucumber.)"] if @process.nil?
    log = @process.get_log(:out) + @process.get_log(:err)
    log.sort!{|a,b| a.time <=> b.time}
    if max_lines > 0
      return log.last(max_lines)
    else
      return log
    end
  end

end