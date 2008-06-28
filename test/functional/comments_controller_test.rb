require File.dirname(__FILE__) + '/../test_helper' 
require 'comments_controller' 

# Re-raise errors caught by the controller. 
class CommentsController; def rescue_action(e) raise e end; end 

class CommentsControllerTest < Test::Unit::TestCase 
  fixtures :comments, :posts, :blogs, :users, :specs, :geo_data

  def setup 
    @controller = CommentsController.new 
    @request = ActionController::TestRequest.new 
    @response = ActionController::TestResponse.new 
    @user = users(:valid_user) 
    authorize @user 
    @comment = comments(:one) 
    @post = posts(:one) 
    @valid_comment = { :user_id => @user, :post_id => @post, 
                       :body => "Comment Body"} 
  end 

  def test_new_comment 
    xhr :get, :new, :blog_id => @post.blog, :post_id => @post 
    assert_response :success 
  end 
  
  def test_create_comment 
    old_count = Comment.count 
    xhr :post, :create, :blog_id => @post.blog, 
                        :post_id => @post, 
                        :comment => @valid_comment 
    assert_response :success 
    assert_equal old_count+1, Comment.count 
  end 

  def test_delete_comment 
    old_count = Comment.count 
    xhr :delete, :destroy, :blog_id => @comment.post.blog, 
                           :post_id => @comment.post, 
                           :id => @comment 
    assert_response :success 
    assert_equal old_count-1, Comment.count 
  end 

  # Make sure unauthorized users can't delete comments and get redirected. 
  def test_unauthorized_delete_comment 
    @request.session[:user_id] = 2 # Unauthorized user 
    xhr :delete, :destroy, :blog_id => @comment.post.blog, 
                           :post_id => @comment.post, 
                           :id => @comment 
    assert_response :redirect 
    assert_redirected_to hub_url 
  end 
end