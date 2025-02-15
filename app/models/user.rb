class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :inverse_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :friend_requests, through: :inverse_friendships, source: :user

  has_many :friendships

  def friends_and_own_posts
    Post.ordered_by_most_recent.where(user: friends.push(self))
  end

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def already_friend?(user)
    if unresolved_request.include?(user)
      true
    else
      friend_requests.include?(user)
    end
  end

  def created_inverse?(friend)
    friend.friendships.find_by(friend_id: id).nil?
  end

  def friendship_created?(friend)
    friendships.find_by(friend_id: friend.id).nil? && created_inverse?(friend)
  end

  def confirm_inverse?(friend)
    !friendships.find_by(friend_id: friend.id, confirmed: false).nil?
  end
end
