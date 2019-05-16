include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'User edit' , :devise do

  after(:each) do
    Warden.test_reset!
  end
  
  scenario "user password changed successfully", js: true do
    user = FactoryGirl.create(:user)
    visit root_path
    find(".icon-menu").click
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click
    
    find('ul.right > li:nth-child(4)').click
    find('li.width100p:nth-child(1) > a:nth-child(1)').click
    expect(page).to have_content 'Edit Profile'

    find("div.left-nav-billing > ul > li:nth-child(4) > a:nth-child(1)").click
    expect(page).to have_content 'Change Password'


    find('#user_password').set('passwordchanged')    
    find("a.save_password_btn").click
    expect(page).to have_content "Password successfully updated."
  end

  # scenario "user password doesn't match", js: true do
  #   user = FactoryGirl.create(:user)
  #   visit root_path
  #   find(".icon-menu").click
    
  #   find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
  #   find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
  #   find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
  #   find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
  #   find('#email-signin-submit').click
    
  #   find('ul.right > li:nth-child(4)').click
  #   find('li.width100p:nth-child(1) > a:nth-child(1)').click
  #   expect(page).to have_content 'Edit Profile'

  #   find('#user_password').set('passwordchanged')
  #   find('#user_password_confirmation').set('passwordmismatch')
  #   find('#user_current_password').set(user.password)
  #   find('div.row:nth-child(12) > div:nth-child(2) > a:nth-child(1)').click
    
  #   expect(page).to have_content "Password confirmation doesn't match Password"
  # end

  # scenario "user password is too short", js: true do
  #   user = FactoryGirl.create(:user)
  #   visit root_path
  #   find(".icon-menu").click
    
  #   find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
  #   find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
  #   find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
  #   find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
  #   find('#email-signin-submit').click
    
  #   find('ul.right > li:nth-child(4)').click
  #   find('li.width100p:nth-child(1) > a:nth-child(1)').click
  #   expect(page).to have_content 'Edit Profile'

  #   find('#user_password').set('pass')
  #   find('#user_password_confirmation').set('pass')
  #   find('#user_current_password').set(user.password)
  #   find('div.row:nth-child(12) > div:nth-child(2) > a:nth-child(1)').click
    
  #   expect(page).to have_content "Password is too short (minimum is 8 characters)"
  # end

  # scenario "Current password is invalid", js: true do
  #   user = FactoryGirl.create(:user)
  #   visit root_path
  #   find(".icon-menu").click
    
  #   find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
  #   find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
  #   find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
  #   find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
  #   find('#email-signin-submit').click
    
  #   find('ul.right > li:nth-child(4)').click
  #   find('li.width100p:nth-child(1) > a:nth-child(1)').click
  #   expect(page).to have_content 'Edit Profile'

  #   find('#user_password').set('password')
  #   find('#user_password_confirmation').set('password')
  #   find('#user_current_password').set('wrongpassword')
  #   find('div.row:nth-child(12) > div:nth-child(2) > a:nth-child(1)').click
    
  #   expect(page).to have_content "Current password is invalid"
  # end

  # scenario "Blank current password", js: true do
  #   user = FactoryGirl.create(:user)
  #   visit root_path
  #   find(".icon-menu").click
    
  #   find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
  #   find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
  #   find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
  #   find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
  #   find('#email-signin-submit').click
    
  #   find('ul.right > li:nth-child(4)').click
  #   find('li.width100p:nth-child(1) > a:nth-child(1)').click
  #   expect(page).to have_content 'Edit Profile'

  #   find('#user_password').set('password')
  #   find('#user_password_confirmation').set('password')
  #   find('#user_current_password').set('')
  #   find('div.row:nth-child(12) > div:nth-child(2) > a:nth-child(1)').click
    
  #   expect(page).to have_content "Current password can't be blank"
  # end

  scenario 'sign in after password changed', js: true do
    user = FactoryGirl.create(:user)
    visit root_path
    find(".icon-menu").click
    
    #########################################################
    ## Open slide out menu and sign in
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click
    #########################################################
    
    ####### Verify if its a Dashboard #######
    expect(page).to have_content "Your Stats"
    expect(page).to have_content "Reviewed Applicants"
    expect(page).to have_content "Unreviewed Applicants"
    expect(page).to have_content "Shortlisted Applicants"
  end
end