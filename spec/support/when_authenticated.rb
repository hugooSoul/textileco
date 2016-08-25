RSpec.shared_context 'When authenticated' do
  background do
    authenticate
  end

  def authenticate
    visit '/'
    click_link 'Log In'
    within('form#new_employee') do
      fill_in 'Email', :with => 'example@example.com'
      fill_in 'Password', :with => 'admin123?a'
    end
    click_button 'Log in'
  end
end
