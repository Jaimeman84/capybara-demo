require 'spec_helper'

RSpec.describe 'Task Management', type: :feature do
  describe 'Homepage' do
    it 'displays the task manager title' do
      visit '/'
      expect(page).to have_content('Task Manager')
    end

    it 'shows empty state when no tasks exist' do
      visit '/'
      expect(page).to have_content('No tasks yet')
    end
  end

  describe 'Adding tasks' do
    it 'allows user to add a new task' do
      visit '/'

      fill_in 'task_name', with: 'Buy groceries'
      click_button 'Add Task'

      expect(page).to have_content('Buy groceries')
      expect(page).not_to have_content('No tasks yet')
    end

    it 'allows user to add multiple tasks' do
      visit '/'

      fill_in 'task_name', with: 'Buy groceries'
      click_button 'Add Task'

      fill_in 'task_name', with: 'Walk the dog'
      click_button 'Add Task'

      fill_in 'task_name', with: 'Clean the house'
      click_button 'Add Task'

      expect(page).to have_content('Buy groceries')
      expect(page).to have_content('Walk the dog')
      expect(page).to have_content('Clean the house')
    end
  end

  describe 'Completing tasks' do
    before do
      visit '/'
      fill_in 'task_name', with: 'Complete this task'
      click_button 'Add Task'
    end

    it 'allows user to mark a task as complete' do
      click_button 'Complete'

      # Task should still be visible but marked as completed
      expect(page).to have_content('Complete this task')

      # Complete button should not be visible for completed tasks
      within('.task-item.completed') do
        expect(page).not_to have_button('Complete')
      end
    end
  end

  describe 'Deleting tasks' do
    before do
      visit '/'
      fill_in 'task_name', with: 'Task to delete'
      click_button 'Add Task'
    end

    it 'allows user to delete a task' do
      expect(page).to have_content('Task to delete')

      click_button 'Delete'

      expect(page).not_to have_content('Task to delete')
      expect(page).to have_content('No tasks yet')
    end
  end

  describe 'Full workflow' do
    it 'supports adding, completing, and deleting tasks' do
      visit '/'

      # Add multiple tasks
      fill_in 'task_name', with: 'Morning jog'
      click_button 'Add Task'

      fill_in 'task_name', with: 'Read a book'
      click_button 'Add Task'

      fill_in 'task_name', with: 'Write code'
      click_button 'Add Task'

      # Verify all tasks are present
      expect(page).to have_content('Morning jog')
      expect(page).to have_content('Read a book')
      expect(page).to have_content('Write code')

      # Complete one task
      first('.task-item', text: 'Read a book').click_button('Complete')

      # Verify task is marked as completed
      within('.task-item.completed') do
        expect(page).to have_content('Read a book')
      end

      # Delete one task
      first('.task-item', text: 'Morning jog').click_button('Delete')

      # Verify task is deleted
      expect(page).not_to have_content('Morning jog')
      expect(page).to have_content('Read a book')
      expect(page).to have_content('Write code')
    end
  end
end
