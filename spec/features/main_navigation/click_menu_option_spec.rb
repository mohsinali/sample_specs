require 'rails_helper'

feature 'Navigation Links' do 

  let!(:user) { FactoryGirl.create(:user) }

  scenario "User can use Main navigation on Home Page", js: true do

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

    find('ul.right > li:nth-child(1) > a:nth-child(1)').click

    find('.icon-menu').click
    find('#slide-out > li:nth-child(6) > a:nth-child(1)').click
    expect(page).to have_content 'My Location'
    expect(page).to have_content 'Set your location'
  end

  scenario "Visitor click logo from home page", js: true do

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
    find('.brand-logo > img:nth-child(1)').click
    find('.yj-navlink').text == 'DASHBOARD'

  end

  scenario "Logo changes colour on scrolling page down", js: true do
    visit root_path
    page.find('.brand-logo > img:nth-child(1)')['src'].should have_content '/assets/marks/yapjobs-logo-green.svg'
    page.execute_script('window.scrollTo(0,10000)')
    page.find('.brand-logo > img:nth-child(1)')['src'].should have_content '/assets/marks/yapjobs-logo-colour.svg'
  end

  scenario "Visitor click Post a job but not signed in", js: true do

    visit '/'
    find('a.waves-effect.waves-light.btn.yj-btn-green.yj-nav-btn-alt.home_post_a_job_btn').click

    expect(page).to have_content 'Post a Job'
    expect(page).to have_content 'Please enter the job details below'
    find('#btn_add_job').text == 'YAP'
  end

  scenario "Visitor click Post a job and user is signed in", js: true do

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
    find('a.waves-effect.waves-light.btn.yj-btn-green.yj-nav-btn-alt.home_post_a_job_btn').click

    expect(page).to have_content 'Post a Job'
    expect(page).to have_content 'Please enter the job details below'
    find('#btn_add_job').text == 'YAP'
  end

  scenario "should show navigation links", js: true do
    visit '/'
    find(".icon-menu").click   
    
    expect(page).to have_content 'About Us'
    expect(page).to have_content 'Jobs'
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
    expect(page).to have_content 'My Location'
    find('.yj-nav-btn').text == 'POST A JOB'
  end

end