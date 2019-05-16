require 'rails_helper'

feature 'Edit Job' do 
  let!(:user) { FactoryGirl.create(:user, email: "tester@testing.com", password: "testing123") }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, business: business, job_role: job_role, user: user) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }
  
  before do
    allow(Search).to receive(:job_seeker).and_return([job_seeker])
    allow_any_instance_of(Job).to receive(:send_push).and_return([])
    allow_any_instance_of(Job).to receive(:posted_email).and_return(true)
  end

  scenario "User edit changeable fields and update job", js: true do

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

    find('.fa-edit').click
    expect(page).to have_content 'Edit a Job'
    
  end

end