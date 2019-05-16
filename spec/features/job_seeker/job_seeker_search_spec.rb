require 'rails_helper'

feature 'invite to Job seeker' do 

  let!(:job_role) { FactoryGirl.create(:job_role , slug: "slugg") }
  let!(:user) { FactoryGirl.create(:user, email: 'testing@yapjobs.com') }
  let!(:job) { FactoryGirl.create(:job , job_role: job_role,user: user) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }
  let!(:job_seeker1) { FactoryGirl.create(:job_seeker, first_name: 'alpha', last_name: 'bravo', slug: 'slug1', user: user ) }
  let!(:job_seeker2) { FactoryGirl.create(:job_seeker, first_name: 'charlee', last_name: 'tango', slug: 'slug2', user: user ) }
  let!(:job_seeker3) { FactoryGirl.create(:job_seeker, first_name: 'chilli', last_name: 'sour', slug: 'slug3', user: user ) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job,job_seeker: job_seeker) }
  let!(:email_content) { FactoryGirl.create(:email_content, email_title: 'Welcome!') }

  before do
    allow(Search).to receive(:job_seeker).and_return([job_seeker, job_seeker1,job_seeker2,job_seeker3])
    Business.stub_chain(:friendly, :find).and_return(business)
  end

  scenario "job seeker invited by user", js: true do
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
    expect(page).to have_content 'Your Stats'

    find('ul.right > li:nth-child(1) > a:nth-child(1)').click
    find('.ctc-list-hero > li:nth-child(1) > a:nth-child(1)').click
    expect(page).to have_content 'Jobseeker Search Results'  
    expect(page).to have_content job_seeker.first_name
    expect(page).to have_content job_seeker1.first_name
    expect(page).to have_content job_seeker2.first_name
    expect(page).to have_content job_seeker3.first_name
    expect(page).to have_content job_seeker.last_name
    expect(page).to have_content job_seeker1.last_name
    expect(page).to have_content job_seeker2.last_name
    expect(page).to have_content job_seeker3.last_name
  end
end