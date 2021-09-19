class SelfFriendshipValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base].push("You can't be friends with yourself") if record.user_id == record.friend_id
  end
end

class Friendship < ApplicationRecord
  include ActiveModel::Validations
  validates_with SelfFriendshipValidator

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true

  def confirm_friend
    # self.update_attributes(confirmed: true)
    Friendship.create!(friend_id: user_id,
                       user_id: friend_id,
                       confirmed: true)
  end

  def exist?(current_user, user)
    i_requested = !Friendship.find_by(user_id: current_user.id, friend_id: user.id, confirmed: false).empty
    requested_to_me = !Friendship.find_by(user_id: user.id, friend_id: current_user.id, confirmed: false).empty
    i_requested || requested_to_me
  end

  def confirmed_friendship?(current_user, user)
    i_requested = !Friendship.find_by(user_id: current_user.id, friend_id: user.id, confirmed: false).empty
    requested_to_me = !Friendship.find_by(user_id: user.id, friend_id: current_user.id, confirmed: false).empty
    i_requested || requested_to_me
  end

  def self.double_search_requested(current_user, user)
    case1 = Friendship.find_by(user_id: current_user, friend_id: user, confirmed: false)
    case2 = Friendship.find_by(user_id: user, friend_id: current_user, confirmed: false)
    return current_user.friendships.build(friend_id: user) unless case1 || case2

    if case1.nil?
      case2
    elsif case2.nil?
      case1
    end
  end

  def self.double_search_confirmed(current_user, user)
    if Friendship.find_by(user_id: current_user, friend_id: user, confirmed: true).empty?
      Friendship.find_by(user_id: user, friend_id: current_user, confirmed: true).id
    else
      Friendship.find_by(user_id: current_user, friend_id: user, confirmed: true).id
    end
  end
end
