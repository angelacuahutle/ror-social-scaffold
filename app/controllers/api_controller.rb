class ApiController < ActionController::API
    def show_posts
        render :json => Post.all
    end
end
  