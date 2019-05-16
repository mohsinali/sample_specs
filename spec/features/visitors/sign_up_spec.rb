require 'rails_helper'
require 'support/omniauth'

feature 'Sign Up', :devise do

  before do
    visit '/'
    find('.icon-menu').click
    find(:xpath, '//*[@id="slide-out"]/li[5]/a').click
    expect(page).to have_content 'Email'
    find(:xpath, '//*[@id="sign-up"]/div/div[3]/a[4]').click
    expect(page).to have_content 'Email Sign Up'
    allow_any_instance_of(UserMailer).to receive(:welcome_email).and_return(true)
  end

  scenario 'visitor can sign up using facebook and allowed permissions', js: true do

    visit '/'
    find('.icon-menu').click
    find(:xpath, '//*[@id="slide-out"]/li[5]/a').click
    expect(page).to have_content 'Email'
    set_omniauth('facebook')
    find('#sign-up > div:nth-child(1) > div:nth-child(3) > a:nth-child(1)').click

    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  # scenario "visitor can sign up using facebook and doesn't allowed permissions", js: true do
  #   facebook_user = FactoryGirl.create(:user, uid: "1234",\
  #   password: '12343213', provider: 'facebook', first_name: 'first', last_name: 'last')
  #   allow(User).to receive(:find_for_facebook_oauth).and_return(facebook_user)

  #   visit '/'
  #   find('.icon-menu').click
  #   find(:xpath, '//*[@id="slide-out"]/li[5]/a').click
  #   expect(page).to have_content 'Email'
  #   set_invalid_omniauth('facebook')
  #   find('#sign-up > div:nth-child(1) > div:nth-child(3) > a:nth-child(1)').click

  # end

  scenario 'visitor can sign up using google and allowed permissions', js: true do
    
    visit '/'
    find('.icon-menu').click
    find(:xpath, '//*[@id="slide-out"]/li[5]/a').click
    expect(page).to have_content 'Email'
    set_omniauth('google_oauth2')
    find('#sign-up > div:nth-child(1) > div:nth-child(3) > a:nth-child(2)').click

    expect(page).to have_content 'Successfully authenticated from Google account.'
  end

  scenario 'visitor can sign up using linkedin and allowed permissions', js: true do
    
    visit '/'
    find('.icon-menu').click
    find(:xpath, '//*[@id="slide-out"]/li[5]/a').click
    expect(page).to have_content 'Email'
    set_omniauth('linkedin')
    find('#sign-up > div:nth-child(1) > div:nth-child(3) > a:nth-child(3)').click

    expect(page).to have_content 'Successfully authenticated from Linkedin account.'
  end

  #scenario 'user receive email after successful sign up', js: true do
  #  linkedin_user = FactoryGirl.create(:user, email: "user@linkedin.com", uid: "1234",\
  #  password: '12343213', provider: 'google', name: 'my name', first_name: 'first', last_name: 'last')
  #  allow(User).to receive(:connect_to_linkedin).and_return(linkedin_user)
  #  visit '/'
  #  find('.icon-menu').click
  #  find(:xpath, '//*[@id="slide-out"]/li[5]/a').click
  #  expect(page).to have_content 'Email'
  #  set_omniauth()
  #  find('#sign-up > div:nth-child(1) > div:nth-child(3) > a:nth-child(3)').click
#
#  #  expect(page).to have_content 'Successfully authenticated from Linkedin account.'
  #end
  
  scenario 'visitor can sign up with valid email address and password', js: true do

    email_content = FactoryGirl.create(:email_content)
    within("#email_signup_form") do
      fill_in 'user[first_name]', with: "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "email@example.com"
      fill_in 'user[email_confirmation]', :with => "email@example.com"
      fill_in 'user[password]', :with => "password"
      fill_in 'user[password_confirmation]', :with => "password"
    end

    page.execute_script("$('#terms').click()")

    find('#email-signup-submit').click

    expect(page).to have_content 'First Name'
  end

  scenario 'visitor cannot sign up with invalid email address', js: true do
    
    within("#email_signup_form") do
      fill_in 'user[first_name]', :with => "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "invalid_email"
      fill_in 'user[email_confirmation]', :with => "invalid_email"
      fill_in 'user[password]', :with => "password"
      fill_in 'user[password_confirmation]', :with => "password"
    end
    find(:xpath, '//*[@id="email-signup-submit"]').click

    expect(page).to have_content 'Please enter a valid email address.'
  end

  scenario 'visitor cannot sign up without first name', js: true do
    
    within("#email_signup_form") do
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "email@example.com"
      fill_in 'user[email_confirmation]', :with => "email@example.com"
      fill_in 'user[password]', :with => "password"
      fill_in 'user[password_confirmation]', :with => "password"
    end
    find(:xpath, '//*[@id="email-signup-submit"]').click
    expect(page).to have_content 'First name is required'
  end

  scenario 'visitor cannot sign up without password', js: true do
    
    within("#email_signup_form") do
      fill_in 'user[first_name]', :with => "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "invalid_email"
      fill_in 'user[email_confirmation]', :with => "invalid_email"
    end
    find(:xpath, '//*[@id="email-signup-submit"]').click
    expect(page).to have_content 'Password is required.'
  end

  scenario 'visitor cannot sign up with a short password', js: true do
    
    within("#email_signup_form") do
      fill_in 'user[first_name]', :with => "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "email@example.com"
      fill_in 'user[email_confirmation]', :with => "email@example.com"
      fill_in 'user[password]', :with => "short"
      fill_in 'user[password_confirmation]', :with => "short"
    end
    find(:xpath, '//*[@id="email-signup-submit"]').click
    expect(page).to have_content 'Please enter at least 8 characters.'
    
  end

  scenario 'visitor cannot sign up without password confirmation', js: true do
    
    within("#email_signup_form") do
      fill_in 'user[first_name]', :with => "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "email@example.com"
      fill_in 'user[email_confirmation]', :with => "email@example.com"
      fill_in 'user[password]', :with => "password"
    end
    find(:xpath, '//*[@id="email-signup-submit"]').click
    expect(page).to have_content 'Confirm password is required.'
  end

  scenario 'visitor cannot sign up with mismatched password and confirmation', js: true do
    
    within("#email_signup_form") do
      fill_in 'user[first_name]', :with => "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "email@example.com"
      fill_in 'user[email_confirmation]', :with => "email@example.com"
      fill_in 'user[password]', :with => "password"
      fill_in 'user[password_confirmation]', :with => "wrongPassword"
    end
    find(:xpath, '//*[@id="email-signup-submit"]').click
    expect(page).to have_content 'Password and Confirm Password does not match.'
  end

  scenario 'visitor cannot sign up again with already existing email address', js: true do

    email_content = FactoryGirl.create(:email_content)
    within("#email_signup_form") do
      fill_in 'user[first_name]', with: "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "email@example.com"
      fill_in 'user[email_confirmation]', :with => "email@example.com"
      fill_in 'user[password]', :with => "password"
      fill_in 'user[password_confirmation]', :with => "password"
    end

    page.execute_script("$('#terms').click()")

    find('#email-signup-submit').click
    
    expect(page).to have_content 'First Name'
#####
    find('.icon-home2').click
    find(".icon-menu").click
    find("#slide-out > li:nth-child(5) > a:nth-child(1)").click

    find('.icon-menu').click
    find(:xpath, '//*[@id="slide-out"]/li[5]/a').click
    expect(page).to have_content 'Email'
    find(:xpath, '//*[@id="sign-up"]/div/div[3]/a[4]').click
    expect(page).to have_content 'Email Sign Up'

    within("#email_signup_form") do
      fill_in 'user[first_name]', with: "First Name"
      fill_in 'user[last_name]', :with => "last Name"
      fill_in 'user[email]', :with => "email@example.com"
      fill_in 'user[email_confirmation]', :with => "email@example.com"
      fill_in 'user[password]', :with => "password"
      fill_in 'user[password_confirmation]', :with => "password"
    end

    page.execute_script("$('#terms').click()")

    find('#email-signup-submit').click
    
    expect(page).to have_content 'Email has already been taken'
  end

end