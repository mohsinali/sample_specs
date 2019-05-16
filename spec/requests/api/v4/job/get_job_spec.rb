require 'rails_helper'

describe Api::V4::JobsController do 

  let!(:user) { FactoryGirl.create(:user, email: "foo@test.com", password: "testing123") }
  let!(:business) { FactoryGirl.create(:business, user: user) }
  let!(:job_role) { FactoryGirl.create(:job_role, slug: 'thisisslug') }
  let!(:job) { FactoryGirl.create(:job, business: business, job_role: job_role) }
  let!(:client) { FactoryGirl.create(:client, name: "TestClient", api_key: "TestApiKey") }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user) }
  let!(:push_sent) { FactoryGirl.create(:push_sent, job_id: job.id) }
  
  describe "GET api/v4/jobs/:jobID" do
    context "when job is requsted" do
      it "should show requested job" do
        get api_v4_job_path(job.id), {"phone" => job_seeker.phone}, { "HTTP_AUTHORIZATION" => client.api_key }

        job_json = JSON.parse(response.body)['job']
        business_json = JSON.parse(response.body)['job']['business']
        job_role_json = JSON.parse(response.body)['job']['job_role']
        
        expect(job_json["id"]).to eq job.id
        expect(job_json["distance"]).to eq 3559
        expect(job_json["hourly_rate"]).to eq 5.0
        expect(business_json["id"]).to eq business.id
        expect(job_role_json["id"]).to eq job_role.id
        expect(job_json["contract_type"]).to eq true
        expect(job_json["shift_id"]).to eq 1
        expect(job_json["start_date"]).to eq "2015-06-04"
        expect(job_json["start_date_format"]).to eq "04-06-2015"
        expect(job_json["hiring_manager"]).to eq "Manager"
        expect(job_json["location"]).to eq "location"
        expect(job_json["about_job"]).to eq "job details"
        expect(job_json["other_job_role"]).to eq ""
        expect(job_json["postcode"]).to eq "123456"
        expect(job_json["sub_title"]).to eq "new sub title"

        expect(business_json["name"]).to eq business.name
        expect(business_json["location"]).to eq business.location
        expect(business_json["address"]).to eq business.address
        expect(business_json["slug"]).to eq business.slug

        expect(job_role_json["name"]).to eq job_role.name
        expect(job_role_json["slug"]).to eq job_role.slug
        expect(job_role_json["is_active"]).to eq job_role.is_active
        expect(job_role_json["position"]).to eq job_role.position
      end
    end

    context "when job is requsted and push sent is viewed" do
      it "should show requested push sent viewd true" do
        get api_v4_job_path(job.id), {"phone" => job_seeker.phone}, { "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)['job']
        expect(push_sent.reload.viewed).to eq true
      end
    end
  end
end