@login_required
Feature: Login Required Pages
  Background:
    Given I am testing the correct domain

  @login_myaccount
  Scenario: My Account requires CUWebLogin
    Given I go to the home page
      And I click on the "My Account" link
      And I click on the "Login with your NetID or GuestID »" link
    Then I should see the CUWebLogin dialog

  @login_coap_contact
  Scenario: COAP Contact requires CUWebLogin
    Given I go to the home page
      And I click on the "About Us" link
      And I click on the "subject librarians" link
      And I click on the "Cornell Open Access Publication Fund" link
      And I click on the "COAP Contact" link
      And I click on the "this form" link
    Then I should see the CUWebLogin dialog

  @login_coap_application
  Scenario: COAP Application requires CUWebLogin
    Given I go to the home page
      And I click on the "About Us" link
      And I click on the "subject librarians" link
      And I click on the "Cornell Open Access Publication Fund" link
      And I click on the "COAP Application for Funding" link
    Then I should see the CUWebLogin dialog

  @test
  Scenario: I want to test
    Given I go to the home page
    Then I go to page "myacct"
    Then I wait for 1 sec
    Then the page should show content "My Account"
