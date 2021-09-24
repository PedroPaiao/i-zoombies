FactoryBot.define do
  factory :location do
    latitude { rand(0.2..90.0) * [1, -1][rand(0..1)] }
    longitude { rand(0.2..180.0) * [1, -1][rand(0..1)] }

    trait :zero do
      latitude { 0.0 }
      longitude { 0.0 }
    end

    trait :closest do
      latitude { 0.1 }
      longitude { 0.1 }
    end
  end
end
