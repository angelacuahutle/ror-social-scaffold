class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(friend_id: friendship_params[:user_id])
    if @friendship.save
      flash[:notice] = 'Friend request was successfully sent.'
      redirect_to request.referrer
    else
      redirect_to request.referrer, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def show; end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true

    if @friendship.save
      @friendship.confirm_friend
      redirect_to user_path(current_user.id), notice: 'Friend request was successfully confirmed.'
    else
      redirect_to user_path(current_user.id), alert: @friendship.error.full_messages.join('. ').to_s
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      redirect_to request.referrer, notice: 'Friend request declined'
    else
      redirect_to request.referrer, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end

  def request_exist?
    current_user.already_friend?(User.find_by(id: params[:friendship][:friend_id]))
  end
end
