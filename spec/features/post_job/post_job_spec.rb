require 'rails_helper'

feature 'Post a Job' do 
	let!(:user) { FactoryGirl.create(:user, email: "tester@testing.com", password: "testing123") }
	let!(:job_role) { FactoryGirl.create(:job_role) }

	before do
		allow_any_instance_of(Job).to receive(:send_push).and_return([])
		allow_any_instance_of(Job).to receive(:posted_email).and_return(true)
	end

	scenario "Visitor Post a job but not signed in", js: true do

		visit '/'
		find('a.waves-effect.waves-light.btn.yj-btn-green.yj-nav-btn-alt.home_post_a_job_btn').click
		find('#job_business_name').set('New Bussiness Name')
		find('#autocomplete_address').set('Austria')
		fill_in 'autocomplete_address', with: 'A'
		find('div.pac-item:nth-child(1) > span:nth-child(2)').click
		find('#business_city').set('New Bussiness City')
		find('#business_postcode').set('123456')
		find('#job_role_name').click		
		find(:xpath, '//*[@id="1"]/span[2]').click
		find('#job_sub_title').set('New Job Title')
		find('#job_hiring_manager').set('New Hiring Manager')
		find('#job_about_job').set('New About this job')
		find(:xpath, '//*[@id="new_job"]/div[2]/div/div[8]/div[1]/div[1]/input').set('New Responsibility')
		find('#job_hourly_rate').set('6.5')

		page.execute_script("$('#part-time').click()")
		page.execute_script("$('#permanent').click()")
		page.execute_script("$('#Day').click()")		
		page.execute_script("$('#Mon').click()")
		find('#job_twitter_handle').set('New job twitter handle')
		find('#btn_add_job').click

		expect(page).to have_content 'Sign In'
		expect(page).to have_content 'Email'
		expect(page).to have_content 'Google'
		expect(page).to have_content 'LinkedIn'
		expect(page).to have_content 'Facebook'
		expect(page).to have_content 'Sign Up'

		find(:xpath, '//*[@id="sign-up"]/div/div[4]/div/a').click
		find(:xpath, '//*[@id="sign-in"]/div/div[3]/a[4]').click
		find('#email', match: :first).set(user.email)
		find('#password', match: :first).set(user.password)
		find('#email-signin-submit').click

		expect(page).to have_content 'Job was successfully created.'
	end

	scenario "Visitor Post a job as signed in user", js: true do

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
		
		find('a.home_post_a_job_btn').click
		
		find('#job_business_name').set('New Bussiness Name')
		fill_in 'autocomplete_address', with: 'A'
		find('div.pac-item:nth-child(1) > span:nth-child(2)').click
		find('#business_city').set('New Bussiness City')
		find('#business_postcode').set('123456')
		find(:xpath, '//*[@id="job_role_name"]').click		
		find(:xpath, '//*[@id="1"]/span[2]').click
		find('#job_sub_title').set('New Job Title')
		find('#job_hiring_manager').set('New Hiring Manager')
		find('#job_about_job').set('New About this job')
		find(:xpath, '//*[@id="new_job"]/div[2]/div/div[8]/div[1]/div[1]/input').set('New Responsibility')
		find('#job_hourly_rate').set('6.7')
		page.execute_script("$('#part-time').click()")
		page.execute_script("$('#permanent').click()")
		page.execute_script("$('#Day').click()")		
		page.execute_script("$('#Mon').click()")
		find('#job_twitter_handle').set('New job twitter handle')
		find('#btn_add_job').click

		expect(page).to have_content 'Job published successfully, you’re on fire!'
	end

	scenario "Visitor Post a job but not signed in and validation failed", js: true do

		visit '/'
		find('a.waves-effect.waves-light.btn.yj-btn-green.yj-nav-btn-alt.home_post_a_job_btn').click
		find('#job_business_name').set('New Bussiness Name')
		find('#business_city').set('New Bussiness City')
		find('#business_postcode').set('123456')
		find('#job_sub_title').set('New Job Title')
		find('#job_hiring_manager').set('New Hiring Manager')
		find('#job_about_job').set('New About this job')
		find(:xpath, '//*[@id="new_job"]/div[2]/div/div[8]/div[1]/div[1]/input').set('New Responsibility')
		find('#job_hourly_rate').set('6.7')
		page.execute_script("$('#part-time').click()")
		page.execute_script("$('#permanent').click()")
		page.execute_script("$('#Day').click()")		
		page.execute_script("$('#Mon').click()")
		find('#job_twitter_handle').set('New job twitter handle')
		find('#btn_add_job').click

		expect(page).to have_content 'Address is required.'
		
	end

	scenario "Visitor Post a job as signed in user and validation failed", js: true do

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
		
		find('a.home_post_a_job_btn').click
		
		find('#job_business_name').set('New Bussiness Name')
		find('#business_city').set('New Bussiness City')
		find('#business_postcode').set('123456')
		find('#job_sub_title').set('New Job Title')
		find('#job_hiring_manager').set('New Hiring Manager')
		find('#job_about_job').set('New About this job')
		find(:xpath, '//*[@id="new_job"]/div[2]/div/div[8]/div[1]/div[1]/input').set('New Responsibility')
		page.execute_script("$('#part-time').click()")
		page.execute_script("$('#permanent').click()")
		page.execute_script("$('#Day').click()")		
		page.execute_script("$('#Mon').click()")
		find('#job_twitter_handle').set('New job twitter handle')
		find('#btn_add_job').click

		expect(page).to have_content 'Address is required.'
	end

end