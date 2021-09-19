module UserHelper
  
  # Not in use now
  def current_user?(user)
    current_user == user
  end

  ## conditional rendering
  def friend_request(user)
    render partial: 'friend', locals: { user: user } if current_user.friendship_created?(user) && !current_user?(user)
  end

  def user_info(user)
    request = Friendship.all.double_search_requested(current_user, user)
    # byebug
    if current_user.friends.include?(user)
      render partial: 'user', locals: { user: user }
    elsif current_user.pending_friends.include?(user)
      # byebug
      render partial: 'friendships/confirm_decline', locals: { request: request }
    elsif current_user.friend_requests.include?(user)
      render partial: 'friendships/confirm_decline', locals: { request: request }
    elsif request.nil?
      friend_request(user)
    end
  end

  
end
