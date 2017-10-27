@debugging
Feature: Test anything
  Background: After I show the running environment
    Given I show the running environment
    And I am testing the correct domain

  @debugging_hidden_links
  Scenario: The web site has links hidden to poltergiest
    Given I visit page "libraries"
    Then I test
