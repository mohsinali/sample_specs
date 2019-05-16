require 'rails_helper'

describe Api::V5::InterestedRolesController do 
  
  let!(:job_role) { FactoryGirl.create(:job_role , slug: "slugg") }
  let!(:user) { FactoryGirl.create(:user, email: 'newmail@mail.com') }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker, user: user ) }
  let!(:interested_role) { FactoryGirl.create(:interested_role, job_seeker: job_seeker, job_role: job_role) }

  describe " POST /api/v5/interested_roles/update_all_experience" do

    context "update experience" do
      
      it "should update Interested roles experience successfully." do
        post update_all_experience_api_v5_interested_roles_path, { phone: job_seeker.phone, interested_in: [slug: job_role.slug,\
        experience: 10,employer_name: interested_role.employer_name, employer_city: 'new emp city',job_title: 'new job title'  ] }
        json = JSON.parse(response.body)
        json['status'] == 200
        json['message'] == "Interested roles experience updated successfully."
      end
    end

  end
end