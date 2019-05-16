require 'rails_helper'

feature 'click Find A Job link' do 

  scenario "when user not signed in should show Post a Job page", js: true do
    visit '/'
    find('.cust-v-gap').click
    
    expect(page).to have_content 'Job Search Results'
    expect(page).to have_content 'jobs found'
  end
end