include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'User edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario "user email changed successfully", js: true do
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

    find('#user_email').set('newemail@example.com')
    find('#user_password').set(user.password)
    find('#user_password_confirmation').set(user.password)
    find('#user_current_password').set(user.password)
    find('div.row:nth-child(12) > div:nth-child(2) > a:nth-child(1)').click
    
    expect(page).to have_content "Your account has been updated successfully"
  end

  scenario "user first name changed successfully", js: true do
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

    find('#user_first_name').set('zeeshan')
    find('#user_current_password').set(user.password)
    find('div.row:nth-child(12) > div:nth-child(2) > a:nth-child(1)').click
    
    expect(page).to have_content "Your account has been updated successfully"
  end

  scenario "user last name changed successfully", js: true do
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

    find('#user_last_name').set('ali')
    find('#user_current_password').set(user.password)
    find('div.row:nth-child(12) > div:nth-child(2) > a:nth-child(1)').click
    
    expect(page).to have_content "Your account has been updated successfully"
  end

end