require 'rails_helper'

feature 'Job Sharing from job detail page' do 
  
  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role, name: 'role2')}
  let!(:job_role1) { FactoryGirl.create(:job_role, name: 'role1')}
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:shift){FactoryGirl.create(:shift)}
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business, shift: shift) }
  let!(:job3) { FactoryGirl.create(:job, is_published: false, job_role: job_role1, user: user, business: business, shift: shift) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }
  let!(:applicant1) { FactoryGirl.create(:applicant, job: job3) }

  scenario "Employer can share job", js: true do

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
    page.execute_script('window.scrollTo(0,500)')

    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(2) > i:nth-child(1)').click
    expect(page).to have_content job_role1.name+ ' at'
    find('.icon-share').click
    expect(page).to have_content 'Share Job'
    #expect(page).to have_content 'Your Stats'
  end 

  scenario "Employer can share job using Facebook", js: true do

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
    page.execute_script('window.scrollTo(0,500)')

    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(2) > i:nth-child(1)').click
    expect(page).to have_content job_role1.name+ ' at'
    find('.icon-share').click
    binding.pry
    find('div.modal-btns:nth-child(4) > a:nth-child(1)').click
    #expect(page).to have_content 'Your Stats'
  end

  scenario "Employer can share job using Twitter", js: true do

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
    page.execute_script('window.scrollTo(0,500)')

    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(2) > i:nth-child(1)').click
    expect(page).to have_content job_role1.name+ ' at'
    find('.icon-share').click
    find('.yj-btn-twitter').click
    binding.pry
    #expect(page).to have_content 'Your Stats'
  end
  scenario "Employer can share job using clipboard", js: true do

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
    page.execute_script('window.scrollTo(0,500)')

    find('#archivable_2 > td:nth-child(8) > div:nth-child(1) > a:nth-child(2) > i:nth-child(1)').click
    expect(page).to have_content job_role1.name+ ' at'
    find('.icon-share').click
    find('#global-zeroclipboard-flash-bridge').click
    expect(page).to have_content 'Copy to clipboard'
  end
end