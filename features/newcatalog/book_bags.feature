@newcatalog
@newcatalog_book_bags
@javascript

Feature: Book Bags
  Background:
    Given I show the running environment
    Given I am testing the correct domain

@javascript
@book_bags_logged_in
Scenario: Be sure I am logged in
    Given I go to the home page
    Then show me the cookies!
    Then I close my browser (clearing the session)
    Then show me the cookies!
    Then I go to page "users/auth/saml"
    Then I should see the CUWebLogin dialog
    Then I log in with NETID and PASS
    Then I should see the Two-Step Login dialog
    Then I send a Push to my phone
    Then show me the cookies!
    Then I should be logged in to newcatalog
    Then I save the login

@javascript
@book_bags_still_logged_in
Scenario: I should still be logged in after the first Scenario
  Given I go to the home page
  Then I restore saved login
  Then show me the cookies!
  Then I go to the home page
  Then I should be logged in to newcatalog

@javascript
@book_bags_login_test
Scenario: I should be able to log in with one command
  Given I log in to newcatalog