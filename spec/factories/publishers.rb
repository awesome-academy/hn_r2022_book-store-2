FactoryBot.define do
  factory :publisher do
    name {Faker::FunnyName.name}
    desc {Faker::Lorem.sentence(word_count: 50)}
  end
end
