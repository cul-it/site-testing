@www
@www_form_periodic
@form_periodic
Feature: Periodic Form Submissions To Track Emails
  Background:
    Given PENDING: spam prevention
    Given I am testing the correct domain

  @www_form_periodic_email_test_form
  # https://www.library.cornell.edu/email-test-form-message-only
  Scenario: Check the content of the generated email test
  Given I visit page "email-test-form-message-only"
    And I do not see complaints about javascript
    And I enter periodic test text into "edit-submitted-message" for user "Lester Tester"
    And I hit Submit
  Then I should not see a problem with submission message
    And I should see a webform confirmation message

  @www_form_periodic_email_us
  # https://www.library.cornell.edu/ask/email
  Scenario Outline: Ask a Librarian form email test
  Given I visit page "ask/email"
    And I do not see complaints about javascript
    And I enter "CUL IT Testing" for field "edit-submitted-name"
    And I enter "cul-web-test-confirm@cornell.edu" for field "edit-submitted-your-email-address"
    And I select "Cornell Staff" from popup "edit-submitted-status"
    And I select "<recipient>" from popup "edit-submitted-library"
    And I enter periodic test text into "edit-submitted-your-question" for user "<elist>"  
    And I hit Submit
  Then I should not see a problem with submission message
    And I should see a thank you message
    
    Examples:
      | recipient | elist |
      | Adelson Library (Lab of Ornithology) | adelson_lib@cornell.edu |
      | Africana Library | afrlib@cornell.edu |
      | Engineering Library | engrref@cornell.edu |
      | Fine Arts Library | fineartsref@cornell.edu |
      | Industrial & Labor Relations Library | ilrref@cornell.edu |
      | Kroch Library (Asia) | asiaref@cornell.edu |
      | Kroch Library (Division of Rare and Manuscript Collections) | rareref@cornell.edu |
      | Law Library | lawlib@cornell.edu |
      | Management Library | mgtref@cornell.edu |
      | Mann Library (Agriculture, Life Sciences and Selected Social Sciences) | mann_ref@cornell.edu |
      | Mathematics Library | mathlib@cornell.edu |
      | Music Library | musicref@cornell.edu |
      | Olin Library (Humanities & Social Sciences) | Okuref@cornell.edu |
      | Physical Sciences Library | pslref@cornell.edu |
      | School of Hotel Administration Library | hotellibrary@cornell.edu |
      | Uris Library (Humanities & Social Sciences) | okUref@cornell.edu |
      | Veterinary Library | vetref@cornell.edu |
      | Weill Cornell Medical Library (New York City | infodesk@med.cornell.edu |
      | Weill Cornell Medical College-Qatar, Distributed eLibrary | askalibrarian@qatar-med.cornell.edu |


  @www_form_periodic_request_class_instruction
  # https://www.library.cornell.edu/services/instruction/request
  Scenario Outline: Request Class Instruction form email test
  Given I visit page "services/instruction/request"
    And I do not see complaints about javascript
    And I enter "CUL IT Testing" for field "edit-submitted-instructor-information-instructors-department2"
    And I enter "CUL IT Testing" for field "edit-submitted-instructor-information-instructors-name"
    And I enter "cul-web-test-confirm@cornell.edu" for field "edit-submitted-instructor-information-instructors-email-address"
    And I enter "607-255-9999" for field "edit-submitted-instructor-information-instructors-phone-number"
    And I enter "123" for field "edit-submitted-course-information-number-of-students"
    And I check off "Freshman"
    And I check off "Upper-level"
    And I check off "Graduate"    
    And I enter "CUL IT Testing" for field "edit-submitted-course-information-course-number-and-title"
    And I select "No" from popup "edit-submitted-course-information-blackboard"
    And I enter "CUL IT Testing" for field "edit-submitted-course-information-explanation-of-library-assignment"
    And I enter "CUL IT Testing" for field "edit-submitted-course-information-goals-for-the-library-session"
    And I enter "CUL IT Testing" for field "edit-submitted-course-information-resources"
    And I enter periodic test text into "edit-submitted-course-information-other-information" for user "<elist>"  
    And I select "<recipient>" from popup "edit-submitted-scheduling-information-library"
    And I enter "1/2/34" for field "edit-submitted-scheduling-information-preferred-date"
    And I enter "5/6/78" for field "edit-submitted-scheduling-information-second-choice-date"
    And I enter "9:10" for field "edit-submitted-scheduling-information-time-class-meets"
    And I hit Submit
  Then I should not see a problem with submission message
    And I should see a thank you message
    
    Examples:
      | recipient | elist |
      | Adelson Library at Lab of Ornithology | adelson_lib@cornell.edu |
      | Africana Library | afrlib@cornell.edu |
      | Engineering Library | engrref@cornell.edu |
      | Fine Arts Library | fineartsref@cornell.edu |
      | Hotel Library | hotellibrary@cornell.edu |
      | Industrial and Labor Relations Library | ilrref@cornell.edu |
      | Kroch Library (Asia) | asiaref@cornell.edu |
      | Kroch Library (Division of Rare and Manuscript Collections) | rareref@cornell.edu |
      | Law Library | lawlib@cornell.edu |
      | Management Library | mgtref@cornell.edu |
      | Mann Library (Agriculture, Life Sciences and Selected Social Sciences) | mann_ref@cornell.edu |
      | Mathematics Library | mathlib@cornell.edu |
      | Music Library | musicref@cornell.edu |
      | Olin Library (Humanities and Social Sciences) | Okuref@cornell.edu |
      | Physical Sciences Library | pslref@cornell.edu |
      | Uris Library (Humanities and Social Sciences) | okUref@cornell.edu |
      | Veterinary Library | vetref@cornell.edu |
      | Weill Cornell Medical Library (New York City | infodesk@med.cornell.edu |
      | Weill Cornell Medical College-Qatar, Distributed eLibrary | askalibrarian@qatar-med.cornell.edu |

  @webform_periodic_submission @www.library.cornell.edu
  Scenario: Send a test email to the test form
  Given I am testing domain "https://www.library.cornell.edu"
  Given I visit page "email-test-form"
    And I do not see complaints about javascript
    And I enter "cul-web-test-confirm@cornell.edu" for field "edit-submitted-my-email-address"
    And I select "Testing EGA" from popup "edit-submitted-target-list"
    And I enter "Periodic Testing email with Email Test Form" for field "edit-submitted-subject"
    And I enter periodic test text into "edit-submitted-message" for user "Testing EGA"
    Then I take a screen shot with file name "TestForm"
    And I hit Submit
  Then I should not see a problem with submission message
    And I should see a thank you message
