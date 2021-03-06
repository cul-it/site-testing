@formtest
Feature: Test for basic site function
  Background: After I show the running environment
    Given I show the running environment
    And I am testing the correct domain

  @javascript
  @formtest_js
  Scenario: The web site is up and representing for all-sites
    And I am testing the correct domain
    And I go to the home page
    Then the page should show content "Cornell University"
    And I visit page "user"
    And I do not see complaints about javascript
