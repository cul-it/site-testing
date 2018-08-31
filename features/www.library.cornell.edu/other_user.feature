@www
@www_login
Feature: Logged in as another user
  Background:
    Given I am testing the correct domain

  @www_other_user
  Scenario: I should not be logged in at all
    Given I visit page "user"
    Then there should not be a user logged in
    Then the page should show content "Log In"
    Then the page should show content "Cornell users"
    Then the page should show content "Username *"
    Then the page should show content "Password *"

  @www_front_login_link
  Scenario: The front page should show Staff login not logout
    Given I go to the home page
    Then I should see the Staff login link
