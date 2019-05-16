require 'rails_helper'

feature 'Logo dashboard' do 
  let!(:user) { FactoryGirl.create(:user, email: "tester@testing.com", password: "testing123") }

  scenario "Checking color and logo color of dashboard and presence of logon along-side dashboard", js: true do

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

    find('ul.right > li:nth-child(2) > a:nth-child(1)')['background-color'] == '#616161'
    find('.icon-icons2')['color'] == '#FFF'
    
  end


  scenario "Clicking on dashboard opens dashboard page", js: true do

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

    find('ul.right > li:nth-child(2) > a:nth-child(1)').click
    expect(page).to have_content 'Your Stats'
    expect(page).to have_content user.first_name
    
  end

end