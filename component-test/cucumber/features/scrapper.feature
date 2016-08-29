Feature:
  As Scrapper
  I want to get Sainsbury Grocery Site Ripe Fruits Page
  So that i can scrape all product title, unit price, description
  And page size


  Scenario: Scrape Grocery Site Ripe Fruits Page
    Given Sainsbury Grocery Site Ripe Fruits Page is available
    When Scrapper scrapes the Grocery Site Ripe Fruits Page
    Then Scrapper should output a valid json
    And The json elements should contain keys:
      | key1   |  key2      | key3| key4       |
      | title  |  unit_price| size| description|
    And the keys should correspond to the following items:
      |             title                                       | size  | unit_price | description |
      | Sainsbury's Apricot Ripe & Ready x5                     | 37K   | 3.50       | Apricots    |
      | Sainsbury's Avocado Ripe & Ready XL Loose 300g          | 38K   | 1.50       | Avocados    |
      | Sainsbury's Avocado, Ripe & Ready x2                    | 43K   | 1.80       | Avocados    |
      | Sainsbury's Avocados, Ripe & Ready x4                   | 38K   | 3.20       | Avocados    |
      | Sainsbury's Conference Pears, Ripe & Ready x4 (minimum) | 37K   | 1.50       | Conference  |
      | Sainsbury's Golden Kiwi x4                              | 37K   | 1.80       | Gold Kiwi   |
      | Sainsbury's Kiwi Fruit, Ripe & Ready x4                 | 39K   | 1.80       | Kiwi        |


  Scenario: Scraped json output has correct total
    Given Sainsbury Grocery Site Ripe Fruits Page is available
    When Scrapper scrapes the Grocery Site Ripe Fruits Page
    Then Scrapper should output a valid json
    And The total sum of unit prices should be "15.10"

