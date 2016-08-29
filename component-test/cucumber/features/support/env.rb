require 'erubis'
require 'rspec/expectations'
require 'rspec/matchers'
require 'rest-assured'
require_relative 'assumptions'
require_relative 'under-test'

AfterConfiguration do
  RestAssured::Server.start(:database => ':memory:', :port => 8000)
end

Before do | scenario |
end

After do |scenario|
  STDOUT.puts UnderTest.last_log(200) if scenario.failed?
end

at_exit do
  UnderTest.stop
end