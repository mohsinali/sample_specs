require 'rails_helper'

describe Api::V4::JobsController do 
  
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job) { FactoryGirl.create(:job , job_role: job_role) }
  let!(:client) { FactoryGirl.create(:client) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }

  describe "POST api/v4/jobs/apply" do

    context "when job is requsted with valid key, phone and job process" do
      it "should apply for job successfully." do
        post apply_api_v4_jobs_path, { "phone" => job_seeker.phone, job_id: job.id },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        expect(status).to be 200
      end
    end

    context "with invalid api_key" do
      it "should error about invalid api key." do
        post apply_api_v4_jobs_path, { "phone" => job_seeker.phone, job_id: job.id },{ "HTTP_AUTHORIZATION" => 'invalid_key' }
        json = JSON.parse(response.body)
        expect(json['message']).to eq "Invalid api key."
        expect(json['status']).to be 401
      end
    end

    context "without phone" do
      it "should prompt for phone required." do
        post apply_api_v4_jobs_path, { job_id: job.id },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        expect(json['message']).to eq "Phone is required"
        expect(json['status']).to be 201
      end
    end

     context "when phone doesn't belong to any job seeker" do
      it "should error about job seeker not found." do
        post apply_api_v4_jobs_path, { "phone" => 'wrong_number', job_id: job.id },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        expect(json['message']).to eq "Job seeker not found"
      end
    end

     context "when job is not specified" do
      it "should prompt for job process." do
        post apply_api_v4_jobs_path, { "phone" => job_seeker.phone },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        expect(json['message']).to eq "Please provide a job to process"
        expect(json['status']).to be 201
      end
    end

  end
end