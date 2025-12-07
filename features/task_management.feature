Feature: Task Management
  As a user
  I want to manage my tasks
  So that I can track what I need to do

  Background:
    Given I am on the homepage

  Scenario: View the homepage
    Then I should see "Task Manager"

  Scenario: Empty state when no tasks exist
    Then I should see the empty state message

  Scenario: Add a single task
    When I add a task "Buy groceries"
    Then I should see "Buy groceries"
    And I should not see "No tasks yet"

  Scenario: Add multiple tasks
    When I create the following tasks:
      | Buy groceries    |
      | Walk the dog     |
      | Clean the house  |
    Then I should see "Buy groceries"
    And I should see "Walk the dog"
    And I should see "Clean the house"
    And I should have 3 tasks

  Scenario: Complete a task
    Given I add a task "Finish homework"
    When I complete the task "Finish homework"
    Then the task "Finish homework" should be marked as completed
    And the task "Finish homework" should not show a complete button

  Scenario: Delete a task
    Given I add a task "Task to remove"
    When I delete the task "Task to remove"
    Then I should not see "Task to remove"
    And I should see the empty state message

  Scenario: Complete workflow with multiple operations
    When I add a task "Morning jog"
    And I add a task "Read a book"
    And I add a task "Write code"
    Then I should have 3 tasks

    When I complete the task "Read a book"
    Then the task "Read a book" should be marked as completed

    When I delete the task "Morning jog"
    Then I should not see "Morning jog"
    And I should see "Read a book"
    And I should see "Write code"
    And I should have 2 tasks
