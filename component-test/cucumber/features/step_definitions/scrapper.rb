Given(/^Sainsbury Grocery Site Ripe Fruits Page is available$/) do
  FruitPageHelper.start
  UnderTest.start
end
When(/^Scrapper scrapes the Grocery Site Ripe Fruits Page$/) do
  ScrapperHelper.has_out_put?
end

Then(/^Scrapper should output a valid json$/) do
  ScrapperHelper.valid_json?
end

Then(/^The json elements should contain keys:$/) do |keys_table|
  ScrapperHelper.verify_output_has_keys keys_table
end

Then(/^the keys should correspond to the following items:$/) do |item_table|
  ScrapperHelper.verify_output_has_item_details item_table
end

Then(/^The total sum of unit prices should be "([^"]*)"$/) do |price|
  ScrapperHelper.verify_total_unit_price price
end