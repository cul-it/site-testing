  Feature: Hotel Horizons

  @web_services
  Scenario: Check server web-services
    Given I go to web-services
    Then I should see the text "Hello there"

  @hotel_horizons
  Scenario: Hotel Horizons requires CUWebLogin
    Given I go to page "hotel-horizons-access"
    Then I should see the CUWebLogin dialog
