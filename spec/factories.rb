FactoryBot.define do
  factory :genre do |genre|
    genre.sequence(:title) { Faker::Book.genre }
  end

  factory :book do |book|
    book.sequence(:title) { Faker::Book.title }
    book.sequence(:author) { Faker::Book.author }
    book.sequence(:description) { Faker::Lorem.paragraph }
    draft false
    cover { File.new("#{Rails.root}/spec/image.png") }
  end

  factory :user do |user|
    user.sequence(:email) { Faker::Internet.email }
    user.sequence(:password) { Faker::Internet.password }
  end
end