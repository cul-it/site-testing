@www
@www_form
Feature: Main Search
  Background:
    Given I am testing the correct domain

  @www_form_ask_a_librarian
  # https://www.library.cornell.edu/ask/email
  Scenario Outline: Ask a Librarian form email test
    Given PENDING : so we won't be spamming the email lists by mistake
    Given I visit page "ask/email"
        And I do not see complaints about javascript
        And I enter "James Reidy" for field "edit-submitted-name"
        And I enter "cul-web-test-confirm@cornell.edu" for field "edit-submitted-your-email-address"
        And I select "Cornell Staff" from popup "edit-submitted-status"
        And I select "<library>" from popup "edit-submitted-library"
        And I enter test email question into "edit-submitted-your-question" with sequence "19" and tag "<elist>"
        And I hit Submit
    Then I should not see a problem with submission message
        And I should see a thank you message

    Examples:
      | elist | library |
      | cul-web-test-confirm | Test |
      | Adelson_lib | Adelson Library (Lab of Ornithology) |
      | Africana_Library | Africana Library |
      | engrref | Engineering Library |
      | fineartsref | Fine Arts Library |
      | ilrref | Industrial & Labor Relations Library |
      | asiaref | Kroch Library (Asia) |
      | rareref | Kroch Library (Division of Rare and Manuscript Collections) |
      | library_law | Law Library |
      | mgtref | Management Library |
      | mann_ref | Mann Library (Agriculture, Life Sciences and Selected Social Sciences) |
      | mathlib | Mathematics Library |
      | musicref | Music Library |
      | Okuref | Olin Library (Humanities & Social Sciences) |
      | pslref | Physical Sciences Library |
      | hotellibrary | School of Hotel Administration Library |
      | okUref | Uris Library (Humanities & Social Sciences) |
      | vetref | Veterinary Library |
      | infodesk_med | Weill Cornell Medical Library (New York City |
      | askalibrarian_qatar_med | Weill Cornell Medical College-Qatar, Distributed eLibrary |

  @www_formtest
  @www_formtest_email_us
  # https://www.library.cornell.edu/ask/email
  Scenario Outline: Ask a Librarian form email test
  Given I visit page "ask/email"
      And I do not see complaints about javascript
