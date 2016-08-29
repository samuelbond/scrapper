class ScrapperHelper
  extend RSpec::Matchers
  include Singleton

  def self.verify_output_has_keys(keys_table)
    scrapper_output = get_scrapper_output
    keys_table.hashes.each  do |key|
      size_key = key['key3']
      title_key = key['key1']
      unit_price_key = key['key2']
      description_key = key['key4']
      expect(self.results_has_key(scrapper_output, size_key)).to eq(true)
      expect(self.results_has_key(scrapper_output, title_key)).to eq(true)
      expect(self.results_has_key(scrapper_output, unit_price_key)).to eq(true)
      expect(self.results_has_key(scrapper_output, description_key)).to eq(true)
    end
  end

  def self.verify_output_has_item_details(item_table)
    scrapper_output = get_scrapper_output
    count = 0
    item_table.hashes.each do |item|
      size = item['size']
      title = item['title']
      unit_price = item['unit_price']
      description = item['description']
      results_hash = scrapper_output['results'][count]
      expect(results_hash['size']).to eq(size)
      expect(results_hash['title']).to eq(title)
      expect(results_hash['unit_price'].to_f).to eq(unit_price.to_f)
      expect(results_hash['description']).to eq(description)
      count +=1
    end
  end

  def self.verify_total_unit_price(price)
    scrapper_output = get_scrapper_output
    expect(scrapper_output['total'].to_f).to eq(price.to_f)
  end

  def self.get_scrapper_output
    json_str = UnderTest.get_out[1]
    JSON.parse(json_str)
  end

  def self.results_has_key(json_hash, key)
    json_hash['results'].each do |result_hash|
      value = result_hash[key]
      if value.nil?
        return false
      end
    end
    true
  end

  def self.has_out_put?
    get_scrapper_output.has_key?('results')
  end

  def self.valid_json?
    begin
      JSON.parse(UnderTest.get_out[1])
      return true
    rescue JSON::ParserError => e
      return false
    end
  end

end