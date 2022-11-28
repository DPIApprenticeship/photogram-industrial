task sample_data: :environment do
  p "Creating sample data"

  12.times do
    name = Faker::Name.first_name
    email = "#{name.downcase}@example.com"
    password = "password"

    User.create({username: name, email: email, password: "password", private: [true, false].sample})
  end

  12.times do
    
  end

  p "#{User.count} users have been created."
end
