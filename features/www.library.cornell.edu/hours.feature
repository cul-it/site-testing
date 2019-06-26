@www
@www_hours
Feature: Library Hours
  Background:
    Given I am testing the correct domain

  @www_hours_find
  Scenario: Hours page available
    Given I go to the home page
      And I click on the first 'Libraries and Hours' link
    Then the page title should start with "Libraries and Hours"

  @www_hours_libraries_listing
  Scenario Outline: All the libraries' hours should be available on the hours page
    Given I visit page "libraries"
      And I should see the hours listing for "<library>" with "<hours-listed>"
      And I click on the "<library>" library link
    Then the page should contain headline "<library>"
      And I should see the table of "<library>" hours with row "<hours-table-row>"


    Examples:
      | library | hours-listed | hours-table-row |
      | Africana Library | true | library |
      | Engineering Library | true | false |
      | Fine Arts Library | true | library |
      | Industrial and Labor Relations Library | true | library |
      | Kroch Library, Division of Asia Collections | true | library |
      | Kroch Library, Division of Rare & Manuscript Collections | true | library |
      | Law Library | true | Law Circulation |
      | Library Annex | true | library |
      | Management Library | true | Circulation Desk |
      | Mann Library | true | library-link |
      | Mathematics Library | true | library |
      | Medical Center Archives | false | false |
      | Medical Library | false | false |
      | Music Library | true | library |
      | Olin Library | true | library |
      | Ornithology Library | true | library |
      | Physical Sciences Library (Edna McConnell Clark Library) | true | false |
      | School of Hotel Administration Library | true | Hotel School Library |
      | Uris Library | true | library |
      | Veterinary Library | true | library |

