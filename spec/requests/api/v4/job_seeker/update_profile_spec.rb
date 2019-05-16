require 'rails_helper'

describe Api::V4::JobsController do 
  
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job) { FactoryGirl.create(:job , job_role: job_role) }
  let!(:client) { FactoryGirl.create(:client) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user1) { FactoryGirl.create(:user, email: 'profile@yapjob.com') }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }

  describe "POST /api/v4/job_seekers/update_profile" do

    context "update job seeker profile" do
      it "should update jobb seeker profile successfully." do
        
        post update_profile_api_v4_job_seekers_path,\
        { job_seeker: { location: job_seeker.location, date_of_birth: job_seeker.date_of_birth, postcode: job_seeker.postcode,\
        city: job_seeker.city, phone: job_seeker.phone, user_id: user1.id, status: job_seeker.status, first_name: 'new searcher',\
        last_name: job_seeker.last_name,  about_me: job_seeker.about_me, profile_image: job_seeker.profile_image,\
        email: 'newseeker@jobsearch.com', is_active: job_seeker.is_active, is_available: job_seeker.is_active, permanent_location: job_seeker.permanent_location,\
        allowed_working_in_uk: job_seeker.allowed_working_in_uk, search_job_radius: job_seeker.search_job_radius, apply_quota: job_seeker.apply_quota,\
        experience: job_seeker.experience, education_level: job_seeker.education_level, slug: job_seeker.slug, app_backgrounded_time: job_seeker.app_backgrounded_time},\
        "phone" => job_seeker.phone, job_id: job.id, interested_in: ['WAITER_WAITRESS BARTENDER RETAIL_ASSISTANT'] },{ "HTTP_AUTHORIZATION" => client.api_key }

        json = JSON.parse(response.body)
        json['job_seeker']['id'] == job_seeker.id
        json['job_seeker']['phone'] == job_seeker.phone
        json['job_seeker']['first_name'] == 'new searcher'
        json['job_seeker']['user_id'] == user1.id
        json['job_seeker']['email'] == 'newseeker@jobsearch.com'
        json['job_seeker']['slug'] == job_seeker.slug
        json['message'] == 'Success!'
        expect(status).to be 200
      end
    end

    context "with invalid api_key" do
      it "should error about invalid api key." do
        post update_profile_api_v4_job_seekers_path
        json = JSON.parse(response.body)
        expect(json['message']).to eq "Invalid api key."
        expect(json['status']).to be 401
      end
    end

    context "without phone" do
      it "should prompt for phone required." do
        post update_profile_api_v4_job_seekers_path, { job_id: job.id },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        expect(json['message']) == "Phone is required"
        expect(json['status']).to be 201
      end
    end

    context "when phone doesn't belong to any job seeker" do
      it "should error about job seeker not found." do
        post update_profile_api_v4_job_seekers_path, { "phone" => 'wrong_number', job_id: job.id },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        expect(json['message']) == "Job seeker not found"
      end
    end

  end
end
