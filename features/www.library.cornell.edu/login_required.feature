@www
@www_login_required
Feature: Login Required Pages
  Background:
    Given I am testing the correct domain

  @www_login_myaccount
  Scenario: My Account requires CUWebLogin
    Given I go to the home page
      And I click on the "My Account" menu item
      And I click on the "Log in with your NetID" link
    Then I should see the CUWebLogin dialog

  @www_login_coap_contact
  Scenario: COAP Contact requires CUWebLogin
    Given I go to the home page
      And I click on the "About Us" menu item
      And I click on the "subject librarians" link
      And I click on the "Cornell Open Access Publication Fund" link
      And I click on the "COAP Contact" link
      And I click on the "this form" link
      And I click on the "Login" link
    Then I should see the CUWebLogin dialog

  @www_login_coap_application
  Scenario: COAP Application requires CUWebLogin
    Given I go to the home page
      And I click on the "About Us" menu item
      And I click on the "subject librarians" link
      And I click on the "Cornell Open Access Publication Fund" link
      Then I should see "Cornell University Library's open access publishing grants program is closed" within "div.alert"
    #   And I click on the "COAP Application for Funding" link
    #   And I click on the "Login" link
    # Then I should see the CUWebLogin dialog

  @www_test
  Scenario: I want to test
    Given I go to the home page
    Then I go to page "myacct"
    Then I wait for 1 sec
    Then the page should show content "MY ACCOUNT"
