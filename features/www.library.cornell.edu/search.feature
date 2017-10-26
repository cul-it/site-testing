@search
Feature: Main Search
  Background:
    Given I am testing the correct domain

  @search_autocomplete
  Scenario Outline: Autocomplete should suggest canned items for common searches
    Given I go to the home page
    When I search the catalog for "<typical>"
    Then show me the page after sleeping "10"
    Then the catalog search should suggest "<best>"

    Examples:
      | typical | best                                  |
      | hours   | Cornell University Library Hours      |
      | jstor   | JSTOR: the scholarly journal archive  |
