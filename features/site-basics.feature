@site_basics
Feature: Test for basic site function

  @site_up
  Scenario: The web site is up and representing
    Given I go to the home page
    Then the page should show content "Cornell University"
