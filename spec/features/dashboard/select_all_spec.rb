require 'rails_helper'

feature 'Selct All' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:job3) { FactoryGirl.create(:job, is_published: false, job_role: job_role, user: user, business: business) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }
  let!(:applicant1) { FactoryGirl.create(:applicant, job: job3) }

  scenario "On select-label selects all the jobs", js: true do

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

    find('div.m3:nth-child(2) > p:nth-child(1) > label:nth-child(2)').click

    page.execute_script('window.scrollTo(0,500)')
    find('#archivable_2 > td:nth-child(1) > label:nth-child(2)')['checked'] == 'true'
    find('#archivable_1 > td:nth-child(1) > label:nth-child(2)')['checked'] == 'true'
  end
end