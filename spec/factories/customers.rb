FactoryBot.define do
  factory :customer do
    name{ Faker::Name.name }
    email{ Faker::Internet.email }
    phone{ Faker::PhoneNumber.phone_number }
    smoker{ [true, false].sample }
    avatar{ Rails.root.join("spec", "fixtures", "files","avatar.jpeg")}
  end
end