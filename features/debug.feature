@debugging
Feature: Test anything
  Background: After I show the running environment
    Given I show the running environment
    And I am testing the correct domain

  @javascript
  @debugging_hidden_links
  Scenario: The web site has links hidden to poltergiest
    Given PENDING : ares results not working
    When I visit page "ares/search"
      And I search ares for "permanent"
    Then the ares results should contain "Introductory statistical mechanics"

