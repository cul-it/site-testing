@www
@www_login
Feature: Logged in as another user
  Background:
    Given I am testing the correct domain

  @www_other_user
  Scenario: I should not be logged in at all
    Given I go to the home page
    When I click on the "Staff login" link
    Then the page should show content "Log In"
    Then the page should show content "Cornell users"
    Then the page should show content "Username *"
    Then the page should show content "Password *"