require 'rails_helper'

feature 'Mobile AppShare' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:job1) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }
  let!(:applicant1) { FactoryGirl.create(:applicant, job: job1, job_seeker: job_seeker) }

  before do
    allow(Search).to receive(:job_seeker_exclusive).and_return([job_seeker])
  end

  scenario "Mobile_App_Share for IO's", js: true do

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
    find('ul.right > li:nth-child(1) > a:nth-child(1)').click
    page.execute_script('window.scrollTo(0,2500)') 
    find('a.waves-light\.btn:nth-child(1)').click
    binding.pry
    expect(page).to have_content 'Connecting to the iTunes Store'
  end

  scenario "Mobile_App_Share for andriod", js: true do

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
    find('ul.right > li:nth-child(1) > a:nth-child(1)').click
    page.execute_script('window.scrollTo(0,2500)') 
    find('a.waves-light\.btn:nth-child(2)').click
    binding.pry
    expect(page).to have_content 'Connecting to the iTunes Store'
  end

end