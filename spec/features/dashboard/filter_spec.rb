require 'rails_helper'

feature 'Filter Job' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_role1) { FactoryGirl.create(:job_role, name: 'role2') }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:business1) { FactoryGirl.create(:business, name: 'busy 2', user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:job3) { FactoryGirl.create(:job, is_published: false, job_role: job_role1, user: user, business: business1) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }
  let!(:applicant1) { FactoryGirl.create(:applicant, job: job3) }

  scenario "User can filter job by status Job", js: true do

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
    
    find('#archivable_2 > td:nth-child(7) > div:nth-child(1) > label:nth-child(1) > input:nth-child(1)')['checked'] == 'false'
    find('#archivable_1 > td:nth-child(7) > div:nth-child(1) > label:nth-child(1) > input:nth-child(1)')['checked'] == 'true'
    find('#q_is_published_eq').click
    find('#q_is_published_eq > option:nth-child(2)').click
    page.execute_script('window.scrollTo(0,500)')
    
    find('.switch-job')['checked'] == 'true'
    find('#q_is_published_eq').click
    page.execute_script('window.scrollTo(0,500)')
    find('#q_is_published_eq > option:nth-child(1)').click
    find('#q_is_published_eq > option:nth-child(3)').click
    page.execute_script('window.scrollTo(0,500)')
    find('.switch-job')['checked'] == 'false'

    page.execute_script('window.scrollTo(0,500)')
    find('#q_is_published_eq > option:nth-child(1)').click
  end

  scenario "User can filter job by status Role", js: true do

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
    
    find('#q_job_role_id_eq').click
    find('#q_job_role_id_eq > option:nth-child(2)').click
    find('.text-blue').text == job_role.name
    page.execute_script('window.scrollTo(0,500)')

    find('#q_job_role_id_eq').click
    find('#q_job_role_id_eq > option:nth-child(1)').click
    page.execute_script('window.scrollTo(0,500)')
    find('#q_job_role_id_eq').click
    find('#q_job_role_id_eq > option:nth-child(3)').click
    find('.text-blue').text == job_role1.name
    page.execute_script('window.scrollTo(0,500)')
    
  end

  scenario "User can filter job by Business Name", js: true do

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
    
    find('#q_business_id_eq').click
    find('#q_business_id_eq > option:nth-child(2)').click
    find('.text-blue').text == job_role.name
    find('#q_business_id_eq > option:nth-child(2)')['selected'] == 'true'
    page.execute_script('window.scrollTo(0,500)')

    find('#q_business_id_eq').click
    find('#q_business_id_eq > option:nth-child(1)').click
    find('#q_business_id_eq > option:nth-child(1)')['selected'] == 'true'
    page.execute_script('window.scrollTo(0,500)')

    find('#q_job_role_id_eq').click
    find('#q_business_id_eq > option:nth-child(3)').click
    find('.text-blue').text == job_role1.name
    find('#q_business_id_eq > option:nth-child(3)')['selected'] == 'true'
    page.execute_script('window.scrollTo(0,500)')
    
  end

end