class User < ApplicationRecord
  has_many :requested_friendships, class_name: 'Friendship', foreign_key: :requester_id
  has_many :received_friendships, class_name: 'Friendship', foreign_key: :receiver_id
  has_many :receivers, through: :requested_friendships, class_name: 'User'
  has_many :requesters, through: :received_friendships, class_name: 'User'

  has_many :movie_watches
  has_many :movies, through: :movie_watches

  validates :email, uniqueness: { case_sensitive: false }

  has_secure_password

  def friends
    (requesters + receivers).uniq
  end

  def request_friendship(user)
    user.requesters << self
  end

end