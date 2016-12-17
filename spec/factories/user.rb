FactoryGirl.define do
  factory :user do
    email Faker::Internet.unique.email
    password Faker::Internet.password(8, 20, true)
  end
end
