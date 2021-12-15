FactoryBot.define do
  factory :dive do
    title { Faker::Lorem.characters(number: 15) }
    body { Faker::Lorem.characters(number: 20) }
    dive_point { 12345 }
    water_temperature { 0 }
    maximum_depth { 0 }
    season { 0 }
    dive_shop { 12345 }
    user
  end
end
