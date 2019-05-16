FactoryGirl.define do
  factory :applicant do
    status  1
    notified_for_desktop false
  end
  after(:build) { |applicant| applicant.class.skip_callback(:create, :after, :establish_relation_as_applicant) }
  after(:build) { |applicant| applicant.class.skip_callback(:create, :after, :new_applicant_email) }
end
