FactoryGirl.define do
  factory :user do
    email "mail#{Random.rand(100)}@gmail.com"
    password 'please1234'
    password_confirmation 'please1234'
  end
  factory :story do
    title "title"
    description "desc"
    status "In Dev"
    association :user, factory: :user
  end
end
