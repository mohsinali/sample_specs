FactoryGirl.define do
  factory :subscription do
    stripe_subscription_id "MyString"
user_id 1
started_at "2017-02-22 18:24:37"
expired_at "2017-02-22 18:24:37"
charge_id "MyString"
status 1
stripe_card_id "MyString"
stripe_card_last4 "MyString"
stripe_customer_id "MyString"
  end

end
