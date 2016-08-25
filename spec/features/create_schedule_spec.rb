require 'rails_helper.rb'
require 'support/when_authenticated.rb'

RSpec.feature 'User does something' do
  include_context 'When authenticated'

  #scenario 'can create shedule' do
  #  visit '/schedules'
  #end

end

=begin
feature 'Create Schedule' do
  scenario 'can create shedule' do

    #visit index page
    visit '/'
    click_link 'Log In'

    fill_in 'Email', with: 'email'
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    #current_employee = Capybara::Session.new()
    #current_employee.visit('/schedules')
    #visit '/schedules'

    #click new schedule button
    #click_button 'New Schedule'

    #fill the form to create the Schedule
    #fill_in 'Date', with: 'date'
    #fill_in 'Check In', with: 'hour'
    #fill_in 'Check Out', with: 'hour'

    #click the submit button
    #click_button 'Create Schedule'
  end
end

=end
