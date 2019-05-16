require 'rails_helper'

describe Users::ProfilesController do 
  
  let!(:job_role) { FactoryGirl.create(:job_role , slug: "slugg") }
  let!(:job) { FactoryGirl.create(:job , job_role: job_role) }
  let!(:job1) { FactoryGirl.create(:job , job_role: job_role) }
  let!(:client) { FactoryGirl.create(:client) }
  let!(:user) { FactoryGirl.create(:user, email: 'newmail@mail.com') }
  let!(:job) { FactoryGirl.create(:job , job_role: job_role, user: user) }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }
  let!(:business) { FactoryGirl.create(:business) }

  describe " POST /pub/invite" do

    context "invite user" do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      end
      
      it "should invite successfully." do
        post invite_profiles_path, { profile_id: job.id, job_id: job.id, format: 'js' }
        response.status == 200
        response.message == 'OK'
      end
    end

  end
end