require 'rails_helper'

feature 'Employer Name' do 

  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker) }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role, user: user, business: business) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker) }

  scenario "Click on Name Sign Out and Edit Profile links", js: true do

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

    find('ul.right > li:nth-child(4)')['background-color'] == '#616161'
    find('ul.right > li:nth-child(4)')['color'] == '#FFF'
    find('ul.right > li:nth-child(4)').click

    find('ul.right > li:nth-child(4) > a:nth-child(1)').text == user.first_name+' '+user.last_name
    find('li.width100p:nth-child(1) > a:nth-child(1)').text == 'EDIT PROFILE'
    find('li.width100p:nth-child(3) > a:nth-child(1)').text == 'SIGN OUT'
  end

end