require 'rails_helper'

feature 'Bulk features for Achirve button,drop down option with CheckBox select all' do 
  let!(:user) { FactoryGirl.create(:user, email: "tester@testing.com", password: "testing123") }

  scenario "Checking the Select all CheckBox", js: true do

    visit '/'
    find('.icon-menu').click
    find(:xpath, "//*[@id=\"slide-out\"]/li[4]/a").click
    expect(page).to have_content 'Email'
    
    find('#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)').click
    
    expect(page).to have_content 'Email Sign In'

    within("#sign-in-form > div:nth-child(1)") do
      fill_in 'user[email]', :with => user.email
      fill_in 'user[password]', :with => user.password
    end
    find('#email-signin-submit').click

    find('div.m3:nth-child(2) > p:nth-child(1) > label:nth-child(2)').text == "Select All"
    
  end
  scenario "Checking the Archive button", js: true do

    visit '/'
    find('.icon-menu').click
    find(:xpath, "//*[@id=\"slide-out\"]/li[4]/a").click
    expect(page).to have_content 'Email'
    
    find('#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)').click
    
    expect(page).to have_content 'Email Sign In'

    within("#sign-in-form > div:nth-child(1)") do
      fill_in 'user[email]', :with => user.email
      fill_in 'user[password]', :with => user.password
    end
    find('#email-signin-submit').click

    find('.cust_arch_btn').text == "Archived"
    find('.cust_arch_btn').click
    expect(page).to have_content 'Your Archived Jobs' 
    
  end
  scenario "Checking the Bulk Action", js: true do

    visit '/'
    find('.icon-menu').click
    find(:xpath, "//*[@id=\"slide-out\"]/li[4]/a").click
    expect(page).to have_content 'Email'
    
    find('#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)').click
    
    expect(page).to have_content 'Email Sign In'

    within("#sign-in-form > div:nth-child(1)") do
      fill_in 'user[email]', :with => user.email
      fill_in 'user[password]', :with => user.password
    end
    find('#email-signin-submit').click

    find('.yj-btn-bulk-actions').text == "Bulk Actions"

    find('.yj-btn-bulk-actions').click
    find('#bulk-applicant-actions > li:nth-child(1) > a:nth-child(1)').text == "Publish All"
    find('#bulk-applicant-actions > li:nth-child(3) > a:nth-child(1)').text == "Unpublish All"
    find('#bulk-applicant-actions > li:nth-child(5) > a:nth-child(1)').text == "Archive All"
  end
end 
