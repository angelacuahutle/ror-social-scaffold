class ApiController < ActionController::API
  def show_posts
    render :json => Post.all
  end

<<<<<<< HEAD
  def show_comments
    render :json => Comment.where(post_id: params[:post_id])
  end
=======
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
>>>>>>> dd8515f8f750f1c2725eb537299ddd21505224e8
end
