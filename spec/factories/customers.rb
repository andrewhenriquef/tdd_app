FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    avatar "#{Rails.root}/spec/fixtures/avatar.png"
    smoker ['Y', 'N'].sample
  end
end
