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
    
    find('#job_sub_title').set('New Job Title')
    find('#job_hiring_manager').set('New Hiring Manager')
    find('#job_about_job').set('New About this job')
    find('div.form-group-resp:nth-child(2) > div:nth-child(1) > input:nth-child(1)').set('New Responsibility')
    find('#job_hourly_rate').set('6.7')

    page.execute_script("$('#full-time').click()")
    page.execute_script("$('#temporary').click()")
    page.execute_script("$('#Evening').click()")    
    page.execute_script("$('#Mon').click()")
    find('#job_twitter_handle').set('New job twitter handle')
    #binding.pry
    #find('#P165201477').click
    #find('#P165201477_table > tbody:nth-child(2) > tr:nth-child(4) > td:nth-child(1) > div:nth-child(1)').click
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit Job Title and update job", js: true do

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
    
    find('#job_sub_title').set('New Job Title')
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit Hiring Manager and update job", js: true do

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
    
    find('#job_hiring_manager').set('New Hiring Manager')
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit About Job and update job", js: true do

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
    
    find('#job_about_job').set('New About this job')
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit responsibilities and update job", js: true do

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
    
    find('div.form-group-resp:nth-child(2) > div:nth-child(1) > input:nth-child(1)').set('New Responsibility')
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit Hourly rate and update job", js: true do

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
    
    find('#job_hourly_rate').set('6.3')
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit Job Type and update job", js: true do

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
    
    page.execute_script("$('#full-time').click()")
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit Contract Type and update job", js: true do

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
    
    page.execute_script("$('#temporary').click()")
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User edit Job Shift and update job", js: true do

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
    
    page.execute_script("$('#Evening').click()")
    find('#btn_add_job').click

    expect(page).to have_content 'Job was successfully updated.'
  end

  scenario "User can cancel updation of job", js: true do

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

    find('#job_sub_title').set('New Job Title')
    find('div.form-group-resp:nth-child(2) > div:nth-child(1) > input:nth-child(1)').set('New Responsibility')

    page.execute_script("$('#full-time').click()")
    page.execute_script("$('#Evening').click()")    
    find('#job_twitter_handle').set('New job twitter handle')

    find('div.row:nth-child(18) > div:nth-child(1) > a:nth-child(1)').click

    expect(page).to have_content user.first_name
    find('ul.right > li:nth-child(2) > a:nth-child(1)').text == 'DASHBOARD'
  end

#   scenario "User edit Start Date and update job", js: true do

#     visit '/'
#     find('.icon-menu').click
#     find(:xpath, "//*[@id=\"slide-out\"]/li[4]/a").click
#     expect(page).to have_content 'Email'
    
#     find('#sign-in > div:nth-child(1) > div:nth-child(3) > a:nth-child(4)').click
    
#     expect(page).to have_content 'Email Sign In'

#     within("#sign-in-form > div:nth-child(1)") do
#       fill_in 'user[email]', :with => user.email
#       fill_in 'user[password]', :with => user.password
#     end
#     find('#email-signin-submit').click

#     find('.fa-edit').click
#     expect(page).to have_content 'Edit a Job'
# find('div.row:nth-child(17) > div:nth-child(1)').click


#     find('#P571247460').click
#     find(:xpath, "//*[@id=\"P571247460\"]/table/tbody/tr[3]/td[1]/div").click
#     #find('#P1061559434_table > tbody:nth-child(2) > tr:nth-child(2) > td:nth-child(1) > div:nth-child(1)').click
#     #find('#btn_add_job').click
#     #expect(page).to have_content 'Job was successfully updated.'
#   end

end