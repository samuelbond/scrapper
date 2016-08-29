module Fixtures

  def self.load_fixture(path)
    File.read( File.expand_path("../../../fixtures/#{path}", __FILE__))
  end

  def self.get_main_web_page
    load_fixture('fruit_main_page.html')
  end

  def self.get_product_1
    load_fixture('product_1.html')
  end

  def self.get_product_2
    load_fixture('product_2.html')
  end

  def self.get_product_3
    load_fixture('product_3.html')
  end

  def self.get_product_4
    load_fixture('product_4.html')
  end

  def self.get_product_5
    load_fixture('product_5.html')
  end

  def self.get_product_6
    load_fixture('product_6.html')
  end

  def self.get_product_7
    load_fixture('product_7.html')
  end

end