@www
@www_hours
Feature: Library Hours
  Background:
    Given I am testing the correct domain

  @www_hours_find
  Scenario: Hours page available
    Given I go to the home page
      And I click on the 'Libraries and Hours' link
    Then the page title should start with "Libraries and Hours"

  @www_hours_libraries_listing
  Scenario Outline: All the libraries' hours should be available on the hours page
    Given I visit page "libraries"
      And I should see the hours listing for "<library>" with "<hours-listed>"
      Then show me the page
      And I click on the "<library>" library link
    Then the page title should start with "<library>"
      And I should see the table of "<library>" hours


    Examples:
      | library | hours-listed |
      | Africana Library | true |
      | Engineering Library | true |
      | Fine Arts Library | true |
      | Industrial and Labor Relations Library | true |
      | Kroch Library, Division of Asia Collections | true |
      | Kroch Library, Division of Rare & Manuscript Collections | true |
      | Law Library | true |
      | Library Annex | true |
      | Management Library | true |
      | Mann Library | true |
      | Mathematics Library | true |
      | Medical Center Archives | false |
      | Medical Library | false |
      | Music Library | true |
      | Olin Library | true |
      | Ornithology Library | true |
      | Physical Sciences Library (Edna McConnell Clark Library) | true |
      | School of Hotel Administration Library | true |
      | Uris Library | true |
      | Veterinary Library | true |

