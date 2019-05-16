require 'rails_helper'

feature 'Publish/Unpublish Job' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:job1) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:job2) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:job3) { FactoryGirl.create(:job, is_published: false, job_role: job_role, user: user, business: business) }
  let!(:job4) { FactoryGirl.create(:job, is_published: false, job_role: job_role, user: user, business: business) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }
  let!(:applicant1) { FactoryGirl.create(:applicant, job: job1) }
  let!(:applicant2) { FactoryGirl.create(:applicant, job: job2) }
  let!(:applicant3) { FactoryGirl.create(:applicant, job: job3) }
  let!(:applicant4) { FactoryGirl.create(:applicant, job: job4) }

  before do
    allow(Search).to receive(:job_seeker_exclusive).and_return([job_seeker])
  end

  scenario "User can publish Job", js: true do

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
    page.execute_script('window.scrollTo(0,500)')
    find('#archivable_5 > td:nth-child(7) > div:nth-child(1) > label:nth-child(1) > span:nth-child(2)').click
    
    expect(page).to have_content "Job published Successfully, you're on fire!"
    find('#invite_applicants').text == 'INVITE APPLICANTS'
  end

  scenario "User can Unpublish Job when hired successfully", js: true do

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
    page.execute_script('window.scrollTo(0,500)')
    
    find('#archivable_2 > td:nth-child(7) > div:nth-child(1) > label:nth-child(1) > span:nth-child(2)').click
    
    expect(page).to have_content "How did you get on?"

    find('#hired-successfully > label:nth-child(2)').click
    expect(page).to have_content "Awesome!"
  end

  scenario "User can Unpublish Job when more applicants required", js: true do

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
    page.execute_script('window.scrollTo(0,500)')
    
    find('#archivable_2 > td:nth-child(7) > div:nth-child(1) > label:nth-child(1) > span:nth-child(2)').click
    
    expect(page).to have_content "How did you get on?"
    find('#need-more-applicants_unpublish > label:nth-child(2)').click

    expect(page).to have_content "Choose from your matched applicants"
    
    find('#lnk_send_invitation').text == 'Invite'
    find('div.modal-btns:nth-child(6) > a:nth-child(1)').text == 'Cancel'
    find('th.right-align > label:nth-child(2)').text == 'Select All'
  end

  scenario "User can Unpublish Job when No longer recuriting for this position", js: true do

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
    page.execute_script('window.scrollTo(0,500)')
    
    find('#archivable_2 > td:nth-child(7) > div:nth-child(1) > label:nth-child(1) > span:nth-child(2)').click
    
    expect(page).to have_content "How did you get on?"
    
    find('.hire-failure > label:nth-child(2)').click
    
    expect(page).to have_content "Need Help?"
    expect(page).to have_content "Contact our friendly team today and they will"
    expect(page).to have_content "walk you through the process step by step."
    find('#intercom-launch-if-unpublished').text == 'CONTACT US'
    
    find('#intercom-launch-if-unpublished').click
    
    expect(page).to have_content "YapJobs Team"
    expect(page).to have_content "Have a question? Chat with us"
    find('.intercom-composer-textarea > textarea:nth-child(4)')['placeholder'] == 'Start a conversation…'
  end

end