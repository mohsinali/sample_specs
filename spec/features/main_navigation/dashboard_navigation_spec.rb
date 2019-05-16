require 'rails_helper'

feature 'DashBoard Navigation Links' do 

  let!(:user) { FactoryGirl.create(:user) }

  # scenario "User can use Main navigation on Home Page", js: true do

  #   visit '/'
  #   find('.icon-menu').click
  #   find(:xpath, "//*[@id=\"slide-out\"]/li[4]/a").click
  #   expect(page).to have_content 'Email'
    
  #   find('#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)').click
    
  #   expect(page).to have_content 'Email Sign In'

  #   within("#sign-in-form > div:nth-child(1)") do
  #     fill_in 'user[email]', :with => user.email
  #     fill_in 'user[password]', :with => user.password
  #   end
  #   find('#email-signin-submit').click

  #   find('ul.right > li:nth-child(1) > a:nth-child(1)').click
  #   find('.yj-navlink').click
  #   expect(page).to have_content user.first_name

  #   find('ul.right > li:nth-child(1) > a:nth-child(1)').click
  #   find('.icon-menu').click
  #   find('.li-push > a:nth-child(1)').click
  #   expect(page).to have_content user.first_name
  #   find('ul.right > li:nth-child(2) > a:nth-child(1)').text == 'DASHBOARD'

  #   find('ul.right > li:nth-child(2) > a:nth-child(1)').click
  #   expect(page).to have_content user.first_name
  # end

end