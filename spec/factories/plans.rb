FactoryGirl.define do
  factory :plan do
    name "MyString"
stripe_plan_id "MyString"
job_slots 1
candidates 1
db_search false
branded_hiring_page false
video_interview false
interview_scheduler false
smart_hire false
  end

end
