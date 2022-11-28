class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :own_photos, foreign_key: :owner_id, class_name: "Photo"

  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :fan_id, class_name: "Like"
  has_many :liked_photos, through: :likes, source: :photo

  has_many :received_follow_requests, foreign_key: :recipient_id, class_name: "FollowRequest"
  has_many :accepted_received_follow_requests, -> { where status: "accepted"}, foreign_key: :recipient_id, class_name: "FollowRequest"
  has_many :followers, through: :accepted_received_follow_requests, source: :sender

  has_many :sent_follow_requests, foreign_key: :sender_id, class_name: "FollowRequest"
  has_many :accepted_sent_follow_requests, -> { where status: "accepted"}, foreign_key: :sender_id, class_name: "FollowRequest"
  has_many :leaders, through: :accepted_sent_follow_requests, source: :recipient

  has_many :feed, through: :leaders, source: :own_photos
  has_many :discovery, through: :leacers, source: :liked_photos

end
