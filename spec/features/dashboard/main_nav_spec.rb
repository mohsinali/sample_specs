require 'rails_helper'

feature 'Main Nav' do 

  let!(:user) { FactoryGirl.create(:user) }
  
  scenario "Job Information should visible to user", js: true do

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

    expect(page).to have_content user.first_name
    
    find('.brand-logo > img:nth-child(1)')['src'] == '/assets/marks/yapjobs-logo-white.svg'
    find('ul.right > li:nth-child(1) > a:nth-child(1)').text == 'HOME'
    find('ul.right > li:nth-child(2) > a:nth-child(1)').text == 'DASHBOARD'
    find('a.home_post_a_job_btn').text == 'POST A JOB'
    find('ul.right > li:nth-child(4) > a:nth-child(1) > span:nth-child(1)').text == user.first_name+' '+user.last_name
    find('ul.right > li:nth-child(4) > a:nth-child(1) > span:nth-child(1)')['class'] == 'icon-chevron-down alt'
    find('.icon-alarm')['class'] == 'icon-alarm yj-icon icon-space'
  end

end