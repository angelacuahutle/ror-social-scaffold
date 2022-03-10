class ApiController < ActionController::API
  def show_posts
    render :json => Post.all
  end

  def show_comments
    render :json => Comment.where(post_id: params[:post_id])
  end
end
