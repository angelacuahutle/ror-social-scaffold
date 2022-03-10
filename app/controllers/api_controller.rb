class ApiController < ActionController::API
  def show_posts
    render :json => Post.all
  end

  def show_comments
    render :json => Comment.where(post_id: params[:post_id])
  end

  def add_comment
    @comment = Comment.create(post_id: params[:post_id], user_id: params[:user_id], content: params[:content])

    if @comment.save
      render :json => "Comment created successfully!"
    else
      render :json => "Comment not created!"
    end
  end
end
