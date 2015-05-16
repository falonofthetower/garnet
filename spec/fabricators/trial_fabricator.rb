Fabricator(:trial) do
  name { Faker::Name.name }
  url { Faker::Internet.url }
  cancel_url { Faker::Internet.url }
  instructions { Faker::Lorem.paragraph }
end
