Fabricator(:trial) do
  name { Faker::Name.name }
  url { Faker::Internet.url }
  cancel_url { Faker::Internet.url }
  instructions { Faker::Lorem.paragraph }
  expiration_date { Faker::Date.forward(rand(7..30)) }
end
