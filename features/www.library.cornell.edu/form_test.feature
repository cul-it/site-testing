@www
@www_form_test
Feature: Periodic Form Submissions To Track Emails
  Background:
    Given I am testing the correct domain
 Scenario: Send a test email to the test form
  Given I am testing domain "https://www.library.cornell.edu"
  Given I visit page "email-test-form"
    And I do not see complaints about javascript
    And I enter "jgr25@cornell.edu" for field "edit-submitted-my-email-address"
    And I select "Testing EGA" from popup "edit-submitted-target-list"
    And I enter "Periodic Testing email with Email Test Form" for field "edit-submitted-subject"
    And I enter periodic test text into "edit-submitted-message" for user "Testing EGA"
    Then I take a screen shot with file name "TestForm"
    And I hit Submit
  Then I should not see a problem with submission message
    And I should see a thank you message
