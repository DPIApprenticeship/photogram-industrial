task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    # FollowRequest.destroy_all
    User.destroy_all
  end

  12.times do
    name = Faker::Name.first_name
    email = "#{name.downcase}@example.com"
    password = "password"

    User.create({username: name, email: email, password: "password", private: [true, false].sample})
  end

  users = User.all
  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

  users.each do |user|
    rand(5).times do 
      Photo.create(
        image: "some image",
        caption: Faker::TvShows::Simpsons.quote,
        owner_id: user.id
      )
    end
  end

  

  p "#{User.count} users have been created."
  p "#{FollowRequest.count} follow requests have been created"
  p "#{Photo.count} photos have been created"
end
