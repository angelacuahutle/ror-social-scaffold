# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'angel', email: 'angel@pachis.com', password: 'admin123' )
User.create!(name: 'angela', email: 'angela@pachis.com', password: 'admin123' )

50.times do
  User.create!(name: Faker::Name.first_name, email: Faker::Internet.email, password: 'admin123' )
end

25.times do
  random = rand(3..50)
  Friendship.create!(user_id: User.first.id, friend_id: random, confirmed: true )
  Friendship.create!(user_id: User.second.id, friend_id: random, confirmed: true )
end
