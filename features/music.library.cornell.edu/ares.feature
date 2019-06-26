@music
@music_ares
Feature: ares course reserves
  Background:
    Given I am testing the correct domain

  @music_ares_load
  Scenario: Load Ares cache for the other commands
    Given PENDING : ares results not working
    Given I go to the home page
    When I visit page "course-reserves"
      And I select option 1 from the d8_ares popup
      And I wait for the d8_ares results to load
    Then the d8_ares results should show at least one title

  @music_ares_front
  Scenario: Selecting ares item on front page shows results on course-reserves page
    Given PENDING : ares results not working
    Given I go to the home page
      And I select option 3 from the d8_ares popup
      And I wait for the d8_ares results to load
    Then the page title should start with "Course Reserves"
      And I wait for the d8_ares results to load
    Then the d8_ares results should show at least one title

  @music_ares_course_reserves
  Scenario Outline: Selecting various course reserves should show appropriate results
    Given PENDING : ares results not working
    Given I visit page "course-reserves"
    And I select course "<course>" from the d8_ares popup
    And I wait for the d8_ares results to load
    Then the d8_ares results should show "<title>"

  Examples:
  | course | title |
  | MUSIC 0000: | The Beatles : complete scores |
  | MUSIC 1105: | Intervals, scales and temperaments. |
  | MUSIC 1341: | Gender implications of dangdut kampungan |
  | MUSIC 3612: | Songs of West Africa |
  | MUSIC 9999: | RISM. Datenbank auf |