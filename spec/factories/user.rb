FactoryGirl.define do
  factory :user do
    email Faker::Internet.unique.email
    password Faker::Internet.password(
      User::MIN_PASSWORD_LENGTH,
      User::MIN_PASSWORD_LENGTH,
      true)
  end
end
