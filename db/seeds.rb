abort('Dont run seed in production') if Rails.env.production?

puts '\n----> Populating Survivors'
%x(`rails populate:survivors`)

puts '\n----> Updating Locations'
%x(`rails populate:locations`)

puts '\n----> Populating Reports'
%x(`rails populate:reports`)

puts '\n----> Infecting some survivors'
%x(`rails populate:infected_survivors`)