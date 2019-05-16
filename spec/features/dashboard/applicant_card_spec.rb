require 'rails_helper'

feature 'Applicant Cards' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user) }
  let!(:job1) { FactoryGirl.create(:job, job_role: job_role, user: user) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }
  let!(:applicant1) { FactoryGirl.create(:applicant, job: job1, status: 2) }

  scenario "Reviewed Applicants", js: true do

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
    
    find('div.m6:nth-child(1) > div:nth-child(1) > div:nth-child(1)')['h5'] == 'Reviewed Applicants'
    find('div.m6:nth-child(1) > div:nth-child(1) > div:nth-child(1)')['p'] == Applicant.where(status: 1).count
    
    find('div.m6:nth-child(1) > div:nth-child(1) > div:nth-child(1) > a:nth-child(4)').text == 'VIEW ALL'
    find('div.m6:nth-child(1) > div:nth-child(1) > div:nth-child(1) > a:nth-child(4)').click

  end

   scenario "Unreviewed Applicants", js: true do

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
    binding.pry
    find('div.m6:nth-child(2) > div:nth-child(1) > div:nth-child(1)')['h5'] == 'Unreviewed Applicants'
  end

  scenario "Shortlisted Applicants ", js: true do

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
    
    find('div.s12:nth-child(3) > div:nth-child(1) > div:nth-child(1)')['h5'] == 'Shortlisted Applicants'
    find('div.s12:nth-child(3) > div:nth-child(1) > div:nth-child(1)')['p'] == Applicant.where(status: 2).count
  
    find('div.s12:nth-child(3) > div:nth-child(1) > div:nth-child(1) > a:nth-child(4)').click
    expect(page).to have_content 'Applicants'
  end

end