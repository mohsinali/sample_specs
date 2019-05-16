require 'rails_helper'

feature 'Bulk features for Achirve button,drop down option with CheckBox select all' do 
  
  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role, name: 'role2')}
  let!(:job_role1) { FactoryGirl.create(:job_role, name: 'role1')}
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business, is_archive: true) }
  let!(:job3) { FactoryGirl.create(:job, is_published: false, job_role: job_role1, user: user, business: business, is_archive: true) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }
  let!(:applicant1) { FactoryGirl.create(:applicant, job: job3) }

  scenario "Checking the Archive button", js: true do

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

    find('.cust_arch_btn').text == "Archived"
    find('.cust_arch_btn').click
    expect(page).to have_content 'Your Archived Jobs'
    find('#unarchivable_2 > td:nth-child(1) > div:nth-child(1)').text == job_role1.name
    find('#unarchivable_1 > td:nth-child(1) > div:nth-child(1)').text == job_role.name
  end
end
