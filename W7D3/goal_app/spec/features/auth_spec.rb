require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'New user'
  end

  feature 'signing up a user' do
    before(:each) do
        visit new_user_url
        fill_in 'username', with: 'shawn123'
        fill_in 'password', with: 'abc123'
        click_on 'Create User'
    end
    scenario 'shows username on the homepage after signup' do
        expect(page).to have_content 'shawn123'
    end

  end
end

feature 'logging in' do
    given(:user){FactoryBot.create(:user)}
  scenario 'shows username on the homepage after login' do
    visit user_url(:user)
    expect(page).to have_content user.username
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'

end