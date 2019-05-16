require 'rails_helper'

feature 'Check Job Cards' do

  let!(:job_role) { FactoryGirl.create(:job_role, name: 'Waiter / Waitress' , slug: "waiterslug") }
  let!(:job_role1) { FactoryGirl.create(:job_role, name: 'Manager' , slug: "managerslug") }
  let!(:job_role2) { FactoryGirl.create(:job_role, name: 'Receptionist ' , slug: "receptionslug") }
  let!(:user) { FactoryGirl.create(:user, email: 'testing@yapjobs.com') }
  let!(:shift) { FactoryGirl.create(:shift) }
  let!(:job) { FactoryGirl.create(:job , shift: shift, job_role: job_role2,user: user) }
  let!(:job1) { FactoryGirl.create(:job , shift: shift,  job_role: job_role1,user: user) }
  let!(:job2) { FactoryGirl.create(:job , shift: shift,  job_role: job_role,user: user) }
  let!(:business) { FactoryGirl.create(:business, user: user) }

  before do
    allow(Search).to receive(:jobs).and_return([job, job1, job2])
  end

  scenario 'Visitor can see 3 Job Cards and VIEW ALL button below cards', js: true do
    visit root_path
    page.execute_script('window.scrollTo(0,500)')
    expect(page).to have_content 'Waiter / Waitress'
    expect(page).to have_content 'Manager'
    expect(page).to have_content 'Receptionist'
    find('.yj-btn-classy').text == 'VIEW ALL'
  end

  scenario 'All 3 cards have button VIEW JOB', js: true do
    visit root_path
    find('.job-cards > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(3) > a:nth-child(1)').text == 'VIEW JOB'
    find('.job-cards > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > a:nth-child(1)').text == 'VIEW JOB'
    find('div.s12:nth-child(3) > div:nth-child(1) > div:nth-child(3) > a:nth-child(1)').text == 'VIEW JOB'
  end

  scenario 'Click on VIEW JOB button show Job Details', js: true do
    visit root_path
    page.execute_script('window.scrollTo(0,500)')
    find('.job-cards > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(3) > a:nth-child(1)').click
    
    expect(page).to have_content job.sub_title
    expect(page).to have_content business.name.upcase
    find('a.btn-large:nth-child(1)').text == 'APPLY'
    expect(page).to have_content 'job details'
    expect(page).to have_content job_role2.name
  end

  scenario 'Click on VIEW ALL button show Job Search Page', js: true do
    visit root_path
    page.execute_script('window.scrollTo(0,600)')
    find('.yj-btn-classy').click
    
    expect(page).to have_content 'Job Search Results'  
    expect(page).to have_content 'jobs found'
  end

end