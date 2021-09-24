FactoryBot.define do
  factory :survivor, class: Survivor do
    name { Faker::Name.name }
    gender { rand(1..3) }
    location { build(:location) }

    trait :main do
      location { build(:location, :zero) }
    end

    trait :whistleblower_survivor do
      location { build(:location) }
    end

    trait :reported_survivor do
      location { build(:location) }
    end

    trait :close_infected_suvivor do
      reported_reports { build_list(:report, 2) }
    end
  end
end
