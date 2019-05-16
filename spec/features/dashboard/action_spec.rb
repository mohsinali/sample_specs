require 'rails_helper'

feature 'Actions against Job' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_role1) { FactoryGirl.create(:job_role, name: 'role2') }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:shift) { FactoryGirl.create(:shift) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, shift: shift, user: user, business: business) }
  let!(:job1) { FactoryGirl.create(:job, job_role: job_role1, shift: shift, user: user, business: business) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }

  scenario "User can Archive Job", js: true do

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
    
    Job.where(is_archive: false).count == 2
    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(3) > i:nth-child(1)').click
    expect(page).to have_content user.first_name
    Job.where(is_archive: false).count == 1
  end

  scenario "User can View Job", js: true do

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
    
    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(2) > i:nth-child(1)').click
    
    expect(page).to have_content job.hiring_manager
    expect(page).to have_content job_role1.name+ ' at'
    find('.yj-hero-title').text == business.name.upcase
  end

  scenario "User can share Job via Facebook", js: true do

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
    
    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(4)').click
    expect(page).to have_content 'Share this Job'
    set_omniauth
    find('#share_modal_2 > div:nth-child(1) > div:nth-child(4) > a:nth-child(1)').text == 'FACEBOOK'
    find('#share_modal_2 > div:nth-child(1) > div:nth-child(4) > a:nth-child(1)').click
    
   # expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  scenario "User can share Job via Twitter", js: true do

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
    
    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(4)').click
    expect(page).to have_content 'Share this Job'
    
    find('#share_modal_2 > div:nth-child(1) > div:nth-child(4) > a:nth-child(2)').text == 'TWITTER'
    find('#share_modal_2 > div:nth-child(1) > div:nth-child(4) > a:nth-child(2)').click
    
  end

end