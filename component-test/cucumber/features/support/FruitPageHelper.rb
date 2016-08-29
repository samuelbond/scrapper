class FruitPageHelper
  extend RSpec::Matchers
  include Singleton

  def self.setup_fruit_page
    @fruit_page_double = RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/5_products.html', :content => Fixtures.get_main_web_page)
  end

  def self.setup_product_1
    return RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/sainsburys-apricot-ripe---ready-320g.html', :content => Fixtures.get_product_1)
  end
  def self.setup_product_2
    return RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/sainsburys-avocado-xl-pinkerton-loose-300g.html', :content => Fixtures.get_product_2)
  end

  def self.setup_product_3
    return RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/sainsburys-avocado--ripe---ready-x2.html', :content => Fixtures.get_product_3)
  end

  def self.setup_product_4
    return RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/sainsburys-avocados--ripe---ready-x4.html', :content => Fixtures.get_product_4)
  end

  def self.setup_product_5
    return RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/sainsburys-conference-pears--ripe---ready-x4-%28minimum%29.html', :content => Fixtures.get_product_5)
  end

  def self.setup_product_6
    return RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/sainsburys-golden-kiwi--taste-the-difference-x4-685641-p-44.html', :content => Fixtures.get_product_6)
  end

  def self.setup_product_7
    return RestAssured::Double.create(:verb => 'GET', :fullpath => '/2015_Developer_Scrape/sainsburys-kiwi-fruit--ripe---ready-x4.html', :content => Fixtures.get_product_7)
  end

  def self.start
    setup_fruit_page
    setup_product_1
    setup_product_2
    setup_product_3
    setup_product_4
    setup_product_5
    setup_product_6
    setup_product_7
  end

  def self.used_fruit_page?
    @fruit_page_double.wait_for_requests 1, timeout: 10
  end
end