FactoryBot.define do
  factory :order do
    status {"pending"}
    delivery_address {Faker::Address.full_address}
    delivery_phone {Faker::Number.leading_zero_number(digits: 10)}
    shiped_date{Faker::Date.between(from: "2014-09-23", to: "2021-09-25")}
    association :user
    customer_name{Faker::Name.name}
    note{Faker::Lorem.sentence(word_count: 5)}
    before(:create) do |order, evaluator|
      order.order_details << build(:order_detail)
    end
  end
end
