FactoryGirl.define do
  factory :user do
    sequence(:email) { |u| "user_#{u}@example.com" }
    password 'password'
    password_confirmation 'password'

    trait :with_token do
      sequence(:authentication_token) { |u| "random_token_#{u}" }
    end
  end
end
