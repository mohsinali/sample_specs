
feature 'Sign in', :devise do

  let!(:user) { FactoryGirl.create(:user, email: "foo@test.com", password: "testing123") }

  scenario 'open sign in popup' do
    visit root_path
    find(".icon-menu").click

    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
    #expect(page).to have_content 'Password'
    #expect(page).to have_content 'Remember me'
    #expect(page).to have_content 'Sign up'
  end

  scenario 'user cannot sign in if not registered', :js => true do
    visit root_path
    find(".icon-menu").click   
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click

    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set("test@example.com")
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set('1234567')
    find('#email-signin-submit').click

    expect(page).to have_content 'Email or password is not correct.'    
  end

  scenario 'user can sign in with valid credentials', :js => true do
    visit root_path
    find(".icon-menu").click

    user = FactoryGirl.create(:user)
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click
    
    expect(page).to have_content 'Sign out'
  end

  scenario 'user cannot sign in with wrong email', :js => true do
    visit root_path
    find(".icon-menu").click

    user = FactoryGirl.create(:user)   
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click

    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set("wrong@mail.com")
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click
    
    expect(page).to have_content 'Email or password is not correct.'
  end

  scenario 'user cannot sign in with wrong password', :js => true do
    visit root_path
    find(".icon-menu").click

    user = FactoryGirl.create(:user)   
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click

    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set('testtest')
    find('#email-signin-submit').click
    
    expect(page).to have_content 'Email or password is not correct.'
  end

end
