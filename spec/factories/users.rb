FactoryGirl.define do
  factory :user do
    first_name "naam hee"
    last_name "kafi hey"
    name "Test User"
    email "test@example.com"
    password "please123"

    trait :admin do
      role 'admin'
    end

    after(:build) { |user| user.class.skip_callback(:create, :after, :welcome) }
  end

  # factory :user do
  #   first_name "Smith"
  #   name "John Smith"
  #   email "test@example.com"
  #   password "please123"
  #   user_type nil

  #   after(:build) { |user| user.class.skip_callback(:create, :after, :welcome) }
  # end

end
