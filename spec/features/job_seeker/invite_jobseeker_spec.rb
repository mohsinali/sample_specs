require 'rails_helper'

feature 'invite to Job seeker to his Profile' do 

  let!(:job_role) { FactoryGirl.create(:job_role , slug: "slugg") }
  let!(:user) { FactoryGirl.create(:user, email: 'testing@yapjobs.com') }
  let!(:job) { FactoryGirl.create(:job , job_role: job_role,user: user) }
  let!(:job1) { FactoryGirl.create(:job , job_role: job_role,user: user) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job,job_seeker: job_seeker) }

  before do
    allow(Search).to receive(:job_seeker).and_return([job_seeker])
    Business.stub_chain(:friendly, :find).and_return(business)
  end

  scenario "job seeker Profile invitation", js: true do
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
    find('.btn-adjust').click
    expect(page.current_path).to eq "/pub/TestSlug"
    page.execute_script('window.scrollTo(0,500)')
    find('.yj-contact-list > li:nth-child(1) > a:nth-child(1)').click
    binding.pry
    expect(page).to have_content 'Choose a Job to Invite this Profile'
  end
end
