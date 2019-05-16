require 'rails_helper'

feature 'Job Record Information' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }

  scenario "Job Information should visible to user", js: true do

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
    
    find('.yj-btn-global-sm').text == 'VIEW'
    find('.lever')['class'] == 'lever'
    find('a.yj-icon-fa:nth-child(1)')['href'] == '/jobs/#{job.id}/edit'
    find('a.yj-icon-fa:nth-child(2)')['href'] == '/jobs/#{job.id}'
    find('a.yj-icon-fa:nth-child(3)')['href'] == '/jobs/#{job.id}/archive'
    find('a.share > span:nth-child(1)')['title'] == 'Share Job'
  end

end