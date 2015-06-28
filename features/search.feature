Feature: search
  In order to efficiently find entities
  Users should be able to
  use a search
  

  @javascript @wip
  Scenario: do simple search based on title
    Given I am logged in as "admin"
    Given the entity "Bamberg" of kind "Ort/Orte"
    And the entity "Bamberger Apokalypse" of kind "Werk/Werke"
    When I go to the simple search page
    And I fill in "search_terms" with "Bamberg"
    And I press the "enter" key
    Then I should see "Bamberg" within ".entity_list"
    And I should see "Bamberger Apokalypse" within ".entity_list"

  
  @javascript
  Scenario: do exact simple search
    Given I am logged in as "admin"
    Given the entity "Bamberger Apokalypse" of kind "Werk/Werke"
    When I go to the simple search page
    And I fill in "search_terms" with "Bamberger Apokalypse"
    Then I should be on the simple search page


  @javascript @wip
  Scenario: do simple search based on relationship
    Given I am logged in as "admin"
    Given the triple "Werk/Werke" "Bamberger Apokalypse" "befindet sich in/ist Ort von" "Ort/Orte" "Bamberg"
    When I go to the simple search page
    And I fill in "search_terms" with "Apokalypse"
    And I press "Suchen"
    Then I should see "Bamberg" within ".entity_list"
    And I should see "Bamberger Apokalypse" within ".entity_list"


  Scenario: do expert search
    Given I am logged in as "admin"
    Given the entity "Bamberg" of kind "Ort/Orte"
    And the entity "Bamberger Apokalypse" of kind "Werk/Werke"
    When I go to the expert search page
    And I fill in "query[name]" with "Bamberg"
    And I press "Suchen"
    Then I should see "Bamberg" within ".entity_list"
    And I should see "Bamberger Apokalypse" within ".entity_list"


  Scenario: do exact expert search
    Given I am logged in as "admin"
    Given the entity "Bamberger Apokalypse" of kind "Werk/Werke"
    When I go to the expert search page
    And I fill in "query[name]" with "Bamberger Apokalypse"
    And I press "Suchen"
    Then I should be on the expert search page
    
    
  @javascript @elastic
  Scenario: case insensitive search within synonyms
    Given I am logged in as "admin"
    And the entity "Oedipus" of kind "Werk/Werke"
    And the entity "Oedipus" has the synonyms "Ödipus"
    And everything is indexed
    When I go to the expert search
    And I fill in "query[name]" with "ödipus"
    And I press "Suchen"
    Then I should see "Oedipus" within ".search_result"


  @javascript @elastic
  Scenario: Search by dataset values
    Given I am logged in as "admin"
    And kind "Literatur/Literaturen" has field "isbn" of type "Fields::Isbn"
    And the entity "Die Bibel" of kind "Literatur/Literaturen"
    And the entity "Die Bibel" has dataset value "123456789" for "isbn"
    When I go to the expert search page
    And I select "Literatur" from "query[kind_id]"
    Then I should see "Isbn"
    When I press "Suchen"
    Then I should see "Die Bibel" within ".search_result"
    When I fill in "query[dataset][isbn]" with "incorrect"
    When I press "Suchen"
    Then I should not see "Die Bibel"
    When I fill in "query[dataset][isbn]" with "123456789"
    When I press "Suchen"
    Then I should see "Die Bibel" within ".search_result"


  @javascript @elastic
  Scenario: Search by property label and value
    Given I am logged in as "admin"
    And the entity "Die Bibel" of kind "Literatur/Literaturen"
    And the entity "Die Bibel" has property "isbn" with value "123456789"
    When I go to the expert search page
    And I select "Literatur" from "query[kind_id]"
    When I fill in "query[properties]" with "incorrect"
    When I press "Suchen"
    Then I should not see "Die Bibel"
    When I fill in "query[properties]" with "123456789"
    When I press "Suchen"
    Then I should see "Die Bibel" within ".search_result"    
    When I fill in "query[properties]" with "isbn"
    When I press "Suchen"
    Then I should see "Die Bibel" within ".search_result"    


  @javascript @elastic
  Scenario: Put search results into the clipboard and remove them
    Given the entity "Mona Lisa" of kind "Werk/Werke"
    And everything is indexed
    And I am logged in as "admin"
    When I go to the simple search page
    And I fill in "search_terms" with "Mona" and select term "Mona"
    And I click on element "input" within the row for "entity" "Mona Lisa"
    Then I should see "wurde in die Zwischenablage aufgenommen"
    When I click on element "input" within the row for "entity" "Mona Lisa"
    Then I should see "wurde aus der Zwischenablage entfernt"
