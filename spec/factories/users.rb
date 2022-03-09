FactoryBot.define do
  factory :user do
    name{Faker::Name.name_with_middle}
    email{Faker::Internet.email.downcase}
    address{Faker::Address.full_address}
    phone{Faker::Number.leading_zero_number(digits: 10)}
    confirmation_token{"confirm"}
    confirmed_at {DateTime.now}
    password{"password"}
    password_confirmation{"password"}
  end
end
