require 'rails_helper'

feature 'click Start Hiring link' do 

  scenario "when user not signed in should show Post a Job page", js: true do
    visit '/'
    find('.ctc-list-hero > li:nth-child(1) > a:nth-child(1)').click
    
    expect(page).to have_content 'Post a Job'
    find('#btn_add_job').text == 'YAP'
    expect(page).to have_content 'Please enter the job details below'

  end
end