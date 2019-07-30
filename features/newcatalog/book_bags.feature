@newcatalog
@newcatalog_book_bags
@javascript

Feature: Book Bags
  Background:
    Given I show the running environment
    Given I am testing the correct domain

@javascript
@book_bags_logged_in
Scenario: Logging in step by step
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
@book_bags_login_test
Scenario: I should be able to log in with one command
  Given I go to page "users/auth/saml"
  And I log in to the CUWebLogin page
  And I go to the home page
  Then I should be logged in to newcatalog

@javascript
@book_bags_bookmark
Scenario: Items can be selected as bookmarks
  Given I go to the home page
  And I search the catalog for "satan is real"
  And I view the catalog results
  And I select the first 3 catalog result

@javascript
@book_bags_add_to_empty
Scenario: I should be able go to bookbags and add bookbags
  Given I close my browser (clearing the session)
  Then I go to page "users/auth/saml"
  And I log in to the CUWebLogin page
  And I go to the home page
  Then I should be logged in to newcatalog
  And I should see the Book Bag link
  Then I go to my Book Bag
  And I empty my Book Bag
  Then I have an empty Book Bag
  Then I search the catalog for "satan is real"
  And I view the catalog results
  And I select the first 3 catalog results
  And I go to my Book Bag
  Then there should be 3 items seleted
  And I remove the first Book Bag item
  And I go to my Book Bag
  Then there should be 2 items seleted
