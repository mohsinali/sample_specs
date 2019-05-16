require 'rails_helper'

feature 'Post a Job' do 
  let!(:user) { FactoryGirl.create(:user, email: "tester@testing.com", password: "testing123") }
  let!(:job_role) { FactoryGirl.create(:job_role) }

  before do
    allow_any_instance_of(Job).to receive(:send_push).and_return([])
    allow_any_instance_of(Job).to receive(:posted_email).and_return(true)
  end

  scenario "User see Post a job button with green background", js: true do

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

    expect(page).to have_content 'Your Stats'
    find('a.home_post_a_job_btn').text == 'POST A JOB'
    find('a.home_post_a_job_btn')['background-color'] == '#A8C73E'

    find('a.home_post_a_job_btn').click
    expect(page).to have_content 'Post a Job'
    expect(page).to have_content 'Please enter the job details below'
    find('#btn_add_job').text == 'YAP'
  end

end