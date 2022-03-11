require 'swagger_helper'

RSpec.describe 'api/api', type: :request do

    path '/api/posts/comment' do

        post 'Creates a new comment' do
          tags 'New Comment'
          consumes 'application/json'
          parameter name: :comment, in: :body, schema: {
            type: :object,
            properties: {
              user_id: { type: 'integer' },
              post_id: { type: 'integer' },
              content: { type: 'string' }
            },
            required: [ 'user_id', 'post_id', 'content' ]
          }
    
          response '200', 'comment created' do
            let(:comment) { { post_id: 1, user_id: 2, content: 'bar' } }
            run_test!
          end
    
          response '404', 'comment was NOT created' do
            let(:comment) { { title: 'foo' } }
            run_test!
          end
        end
    end

    path '/api/posts' do

        get 'All posts' do
          tags 'Posts'
          consumes 'application/json'
          parameter name: :post, in: :body, schema: {
            type: :object,
          }
    
          response '200', 'Return all posts' do
            run_test!
          end
        end
    end

    path '/api/posts/comments' do

     get 'All comments' do
        tags 'Comments'
        consumes 'application/json'
        parameter name: :comment, in: :body, schema: {
          type: :object,
        }
  
        response '200', 'Return all comments' do
          run_test!
        end
      end
  end
end
