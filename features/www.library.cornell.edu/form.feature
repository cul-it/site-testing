@www
@www_form
Feature: Main Search
  Background:
    Given I am testing the correct domain

  @www_form_ask_a_librarian
  # https://www.library.cornell.edu/ask/email
  # Scenario Outline: Ask a Librarian form email test
  #   Given PENDING : so we won't be spamming the email lists by mistake
  #   Given I visit page "ask/email"
  #       And I do not see complaints about javascript
  #       And I enter "James Reidy" for field "edit-submitted-name"
  #       And I enter "cul-web-test-confirm@cornell.edu" for field "edit-submitted-your-email-address"
  #       And I select "Cornell Staff" from popup "edit-submitted-status"
  #       And I select "<library>" from popup "edit-submitted-library"
  #       And I enter test email question into "edit-submitted-your-question" with sequence "19" and tag "<elist>"
  #       And I hit Submit
  #   Then I should not see a problem with submission message
  #       And I should see a thank you message

  #   Examples:
  #     | elist | library |
  #     | cul-web-test-confirm | Test |
  #     | Adelson_lib | Adelson Library (Lab of Ornithology) |
  #     | Africana_Library | Africana Library |
  #     | engrref | Engineering Library |
  #     | fineartsref | Fine Arts Library |
  #     | ilrref | Industrial & Labor Relations Library |
  #     | asiaref | Kroch Library (Asia) |
  #     | rareref | Kroch Library (Division of Rare and Manuscript Collections) |
  #     | library_law | Law Library |
  #     | mgtref | Management Library |
  #     | mann_ref | Mann Library (Agriculture, Life Sciences and Selected Social Sciences) |
  #     | mathlib | Mathematics Library |
  #     | musicref | Music Library |
  #     | Okuref | Olin Library (Humanities & Social Sciences) |
  #     | pslref | Physical Sciences Library |
  #     | hotellibrary | School of Hotel Administration Library |
  #     | okUref | Uris Library (Humanities & Social Sciences) |
  #     | vetref | Veterinary Library |
  #     | infodesk_med | Weill Cornell Medical Library (New York City |
  #     | askalibrarian_qatar_med | Weill Cornell Medical College-Qatar, Distributed eLibrary |

  @javascript
  @www_forms_available
  Scenario Outline: Assure that each of the public webforms are available to users
    Given I visit page "<formpage>"
    Then show me the page
    Then I should see a Submit button labeled "<label>"

  Examples:
    | formpage | label |
    | research/consultation | Submit |
    # | services/request/recommend | Submit |
    | still-not-able-connect | Send to selected library |
    | 2cul-columbia-library-patron-borrowing-application | Submit |
    | research/citation/help | Submit |
    # | about/collections/coap/application | Submit |
    # | about/collections/coap/contact/form | Submit |
    | services/systematic-review | Submit |
    | ask/email | Submit |
    # | exhibits-form | Submit |
    | services/borrow/library-card | Submit |
    # | about/news/library-insider/recommendation | Submit |
    # | help/trouble-connecting/onsite | Submit |
    | research/consultation | Submit |
    | feedback | Send Mail |
    # | sparktalks/contact | Submit |
    | still-not-able-connect | Send to selected library |
    # | summon-feedback | Submit |
    # | reserves/textbook-request-form | Submit |
    | about/collections/visual-resources/help | Submit |

  @javascript
  @www_forms_require_login
  Scenario Outline: Some forms require login
    Given I visit page "<formpage>"
    Then I should see "<message>" within "div#block-login-tools-login-tools"

  Examples:
    | formpage | message |
    | services/instruction/request | Cornell login required for access to form |
