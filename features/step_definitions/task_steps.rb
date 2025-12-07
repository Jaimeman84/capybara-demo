# Navigation steps
Given('I am on the homepage') do
  visit '/'
end

Given('I visit the task manager') do
  visit '/'
end

# Verification steps
Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

Then('I should not see {string}') do |text|
  expect(page).not_to have_content(text)
end

Then('I should see the empty state message') do
  expect(page).to have_content('No tasks yet')
end

# Task creation steps
When('I add a task {string}') do |task_name|
  fill_in 'task_name', with: task_name
  click_button 'Add Task'
end

When('I create the following tasks:') do |table|
  table.raw.flatten.each do |task_name|
    fill_in 'task_name', with: task_name
    click_button 'Add Task'
  end
end

# Task completion steps
When('I complete the task {string}') do |task_name|
  within('.task-item', text: task_name) do
    click_button 'Complete'
  end
end

Then('the task {string} should be marked as completed') do |task_name|
  within('.task-item.completed') do
    expect(page).to have_content(task_name)
  end
end

Then('the task {string} should not show a complete button') do |task_name|
  within('.task-item.completed', text: task_name) do
    expect(page).not_to have_button('Complete')
  end
end

# Task deletion steps
When('I delete the task {string}') do |task_name|
  within('.task-item', text: task_name) do
    click_button 'Delete'
  end
end

Then('I should have {int} task(s)') do |count|
  expect(page).to have_css('.task-item', count: count)
end
