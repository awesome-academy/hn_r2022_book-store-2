FactoryBot.define do
  factory :book do
    name {Faker::FunnyName.name}
    desc {Faker::Lorem.sentence(word_count: 50)}
    nopage {Faker::Number.between(from: 50, to: 1000)}
    quantity {Faker::Number.between(from: 0, to: 200)}
    price {Faker::Number.between(from: 1, to: 100)}
    category
    publisher
  end
end
