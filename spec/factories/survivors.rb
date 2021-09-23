FactoryBot.define do
  factory :survivor, class: Survivor do
    name { Faker::Name.name }
    gender { rand(1..3) }
    location { build(:location) }

    trait :main do
      location { build(:location, :zero) }
    end
  end
end
