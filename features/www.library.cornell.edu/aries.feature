@www_ares
Feature: ares course reserves
  Background:
    Given I am testing the correct domain

  @www_ares_load
  Scenario: Load Ares cache for the other commands
    Given I go to the home page
    When I visit page "ares/search"
      And I search ares for "PSYCH 1101"
      And I wait for the ares spinner to stop
    Then the ares results should contain "Uris Library Reserve"

  @www_ares_popup
  Scenario: Check the autofill function of the front page popup
    Given I go to the home page
    When I enter "Permanent" in the ares search
      And I select the first option from the ares popup
    Then the ares results should contain "Introductory statistical mechanics"

  @www_ares_sampler
  Scenario Outline: Search ares for reserves for popular courses
    Given I visit page "ares/search"
      And I search ares for "<query>"
      And I wait for the ares spinner to stop
    Then the ares results should contain "<reserve>"

    Examples:
      | query | reserve |
      | PSYCH 1101 | TakeNote |
      | Wines | Wine for dummies |
      | Oceanography | Investigating Oceanography |
      | Music | Music Library Reserve |

