FactoryBot.define do
    factory :post do
      user_id { Faker::Number.number(10) }
      content { Faker::Lorem.word }
    end
end