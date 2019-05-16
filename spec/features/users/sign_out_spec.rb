
feature 'Sign out', :devise do
  let!(:user) { FactoryGirl.create(:user, email: "foo@test.com", password: "testing123") }
 

  # Scenario: User signs out successfully
  #   Given I am signed in
  #   When I sign out
  #   Then I see a signed out message
  
  before do
    visit root_path
    find(".icon-menu").click

    user = FactoryGirl.create(:user)
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click
  end

  scenario 'user signs out successfully', :js => true do
    
    find('.icon-home2').click
    find(".icon-menu").click
    find("#slide-out > li:nth-child(5) > a:nth-child(1)").click
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
  end

end


