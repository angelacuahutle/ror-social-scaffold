module UserHelper
  def current_user?(user)
    current_user == user
  end

  def friend_request(user)
    render partial: 'friend', locals: { user: user } if current_user.friendship_created?(user) && !current_user?(user)
  end

  def user_info(user)
    request = Friendship.all.double_search_requested(current_user, user)
    if current_user.friends.include?(user)
      render partial: 'user', locals: { user: user }
    elsif current_user.friend_requests.include?(user)
      render partial: 'friendships/confirm_decline', locals: { request: request }
    else
      render partial: 'user', locals: { user: user }
    end
  end

  def friends_message(user)
    if current_user?(user)
      content_tag :p, 'Check your profile!'
    elsif current_user.friend?(user)
      content_tag :p, 'You are friends!'
    elsif current_user.pending_friends.include?(user)
      content_tag :p, 'You already sent the request.'
    else
      form_for(current_user.friendships.new, url: user_friendships_path(user)) do |form|
        form.submit 'Add Friend', class: 'btn btn-secondary'
      end
    end
  end
end
