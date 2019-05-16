FactoryGirl.define do
  factory :job do
    job_type false
    hourly_rate 5.0
    business_id 1
    contract_type true
    shift_id 1
    start_date '2015-06-04 00:00:00'
    hiring_manager "Manager"
    location "location"
    about_job "job details"
    postcode "123456"
    remaining_applicants 10
    is_published true
    permanent_location ""
    other_job_role ""
    last_application_time '2015-05-04 00:00:00'
    tta 1
    expires_at '2015-08-04 00:00:00'
    sub_title "new sub title"
    twitter_handle "new twitter handle"
    hired_someone false
    plus_tips false
    is_archive false
    required_to_work ""
  end

end
