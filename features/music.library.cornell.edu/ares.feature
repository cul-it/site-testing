@music
@music_ares
Feature: ares course reserves
  Background:
    Given I am testing the correct domain

  @music_ares_load
  Scenario: Load Ares cache for the other commands
    Given I go to the home page
    When I visit page "ares/search"
      And I search ares for "PSYCH 1101"
      And I wait for the ares spinner to stop
    Then the ares results should contain "Uris Library Reserve"