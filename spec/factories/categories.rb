FactoryBot.define do
  factory :category do
    name {Faker::FunnyName.name}
    desc {Faker::Lorem.sentence(word_count: 50)}
  end
end
