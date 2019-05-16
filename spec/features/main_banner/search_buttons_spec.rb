require 'rails_helper'

feature 'click search buttons on home page' do 

  # let!(:job_role) { FactoryGirl.create(:job_role , slug: "slugg") }
  let!(:user) { FactoryGirl.create(:user, email: 'testing@yapjobs.com') }
  # let!(:job) { FactoryGirl.create(:job , job_role: job_role,user: user) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }
  # let!(:job_seeker1) { FactoryGirl.create(:job_seeker, first_name: 'alpha', last_name: 'bravo', slug: 'slug1', user: user ) }
  # let!(:job_seeker2) { FactoryGirl.create(:job_seeker, first_name: 'charlee', last_name: 'tango', slug: 'slug2', user: user ) }
  # let!(:job_seeker3) { FactoryGirl.create(:job_seeker, first_name: 'chilli', last_name: 'sour', slug: 'slug3', user: user ) }
  # let!(:business) { FactoryGirl.create(:business, user: user) }
  # let!(:applicant) { FactoryGirl.create(:applicant, job: job,job_seeker: job_seeker) }
  # let!(:email_content) { FactoryGirl.create(:email_content, email_title: 'Welcome!') }

  # before do
  #   allow(Search).to receive(:job_seeker).and_return([job_seeker, job_seeker1,job_seeker2,job_seeker3])
  #   Business.stub_chain(:friendly, :find).and_return(business)
  # end

  scenario "click start hiring", js: true do
    visit root_path
    find(".icon-menu").click   
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click

    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click
    expect(page).to have_content user.first_name

    find('ul.right > li:nth-child(1) > a:nth-child(1)').click
    find('.ctc-list-hero > li:nth-child(1) > a:nth-child(1)').click
    expect(page).to have_content 'Jobseeker Search Results'  
    expect(page).to have_content 'jobseekers found'
  end

  scenario "click find a job", js: true do
    visit root_path
    find(".icon-menu").click   
    
    find("#slide-out > li:nth-child(4) > a:nth-child(1)").click  
    find("#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)").click

    find('#email_signin_form > div:nth-child(4) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.email)
    find('#email_signin_form > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)').set(user.password)
    find('#email-signin-submit').click
    expect(page).to have_content user.first_name

    find('ul.right > li:nth-child(1) > a:nth-child(1)').click
    find('.cust-v-gap').click
    expect(page).to have_content 'Job Search Results'  
    expect(page).to have_content 'jobs found'
  end

end