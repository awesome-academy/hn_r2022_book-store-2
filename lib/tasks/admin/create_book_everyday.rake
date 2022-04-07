namespace :admin do
  desc "Update new book every day"

  task create_book_everyday: :environment do
    Publisher.create!(name: Faker::Book.unique.publisher,
                      phone: Faker::Address.full_address)
    Category.create!(name: Faker::Book.unique.genre,
                     desc: Faker::Lorem.sentence(word_count: 15))
    5.times do
      name = Faker::FunnyName.name
      description = Faker::Lorem.sentence(word_count: 50)
      num_pages = Faker::Number.between(from: 50, to: 1000)
      price = Faker::Number.between(from: 1, to: 100)
      quantity = Faker::Number.between(from: 0, to: 200)
      Book.create!(name: name,
                  desc: description,
                  nopage: num_pages,
                  quantity: quantity,
                  price: price,
                  publisher_id: Publisher.all.pluck(:id).sample,
                  category_id: Category.all.pluck(:id).sample)
    end
  end
end
