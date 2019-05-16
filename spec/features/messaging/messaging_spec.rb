require 'rails_helper'

feature "Messaging" do
  let!(:employer) { FactoryGirl.create(:user, email: 'employer@messaging.com', user_type: "job_seeker") }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker)}
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker, status: 4)}

  scenario 'User cannot acces this section without login' do
    visit root_path
    visit messaging_index_path(apc_id: applicant.id)
    expect(page).to have_content "The right people,right here, right now."
  end

  scenario 'User should be able to visit messaging page', js: true do
    visit root_path
    find(".icon-menu").click

    user = FactoryGirl.create(:user)
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click

    expect(page).to have_content 'Sign out'

    visit messaging_index_path(apc_id: applicant.id)

    expect(page).to have_content 'Messaging'
    expect(page).to have_content 'Recent'
    expect(page).to have_content 'Conversation'
  end

  scenario 'User should be able to send message', js: true do
    visit root_path
    find(".icon-menu").click

    user = FactoryGirl.create(:user)
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click  
    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click

    expect(page).to have_content 'Sign out'

    visit messaging_index_path(apc_id: applicant.id)

    expect(page).to have_content 'Messaging'
    expect(page).to have_content 'Recent'
    expect(page).to have_content 'Conversation'
    find('.lnk_compose_message').text == 'Compose'
    find('#chat_message_body').set('message')
    find('i.waves-effect:nth-child(1) > input:nth-child(1)').click

    visit messaging_index_path(apc_id: applicant.id)
    # expect(page).to have_content 'Applied for the job'
  end

end