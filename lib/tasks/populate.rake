namespace :populate do
  task survivors: :environment do
    10.times do
      Survivor.create(name: Faker::Name.name, gender: rand(1..3))
    end
  end

  task locations: :environment do
    Survivor.all.each do |survivor|
      survivor.location = Location.new(
        latitude: rand(0.2..90.0) * [1, -1][rand(0..1)],
        longitude: rand(0.2..180.0) * [1, -1][rand(0..1)]
      )
    end
  end

  task reports: :environment do
    4.times do
      Report.create(
        description: 'I saw blood on him',
        reported_survivor: Survivor.find(Survivor.pluck(:id).sample),
        whistleblower_survivor: Survivor.find(Survivor.pluck(:id).sample)
      )
    end
  end

  task infected_survivors: :environment do
    Survivor.last(3).each do |reported_survivor|
      3.times do
        Report.create(
          description: "It's him!!",
          reported_survivor: reported_survivor,
          whistleblower_survivor: Survivor.find(Survivor.pluck(:id).sample)
        )
      end
    end
  end
end