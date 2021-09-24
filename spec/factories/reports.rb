FactoryBot.define do
  factory :report do
    description { '' }

    whistleblower_survivor { build(:survivor, :whistleblower_survivor) }
    reported_survivor { build(:survivor, :reported_survivor) }
  end
end
