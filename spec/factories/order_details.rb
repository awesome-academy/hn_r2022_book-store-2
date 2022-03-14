FactoryBot.define do
  factory :order_detail do
    quantity{rand(10)}
    price{rand(100)}
    association :order
    association :book
  end
end
