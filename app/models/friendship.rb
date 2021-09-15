class Friendship < ApplicationRecord
include ActiveModel::Validations
# validates_with DupplicateValidator, on: :create
  validates_with SelfFriendshipValidator
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept_request
    update_attributes(confirmed: true)
    Friendship.create!(friend_id: user_id,
                       user_id: friend_id,
                       confirmed: true)
  end
  validates :user, presence: true
  validates :friend, presence: true

  def confirm_friend
    # self.update_attributes(confirmed: true)
    Friendship.create!(friend_id: user_id,
                       user_id: friend_id,
                       confirmed: true)
  end
end
