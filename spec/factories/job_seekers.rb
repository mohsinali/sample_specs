FactoryGirl.define do
  factory :job_seeker do
    location "51.505,-0.0901"
    date_of_birth Date.today
    postcode "54000"
    city "London"
    phone "+12345678"
    status true
    profile_image "image.jpg"
    about_me "developer"
    interested_in "development"
    first_name "Foobar"
    last_name "helloworld"
    sequence(:email) { |n| "person#{n}@example.com" }
    is_active true
    is_available true
    permanent_location "London"
    allowed_working_in_uk true
    search_job_radius 100
    apply_quota 25
    last_active_time DateTime.now - 5.days
    education_level 3
    slug "TestSlug"
    app_backgrounded_time DateTime.now
  end

end
