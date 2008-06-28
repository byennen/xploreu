require File.dirname(__FILE__) + '/../test_helper'
require 'posts_controller'

# Re-raise errors caught by the controller.
class PostsController; def rescue_action(e) raise e end; end

class PostsControllerTest < Test::Unit::TestCase
  fixtures :posts, :blogs, :users

  def setup
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = users(:valid_user)
    authorize @user
    @post = posts(:one)
    @valid_post = { :title => "New title", :body => "New body" }
  end
  
  def test_get_index
    get :index, :blog_id => @post.blog
    assert_response :success
    assert assigns(:posts)
  end

  def test_get_new
    get :new, :blog_id => @post.blog
    assert_response :success
  end
  
  def test_create_post
    old_count = Post.count
    post :create, :blog_id => @post.blog, :post => @valid_post
    assert_equal old_count+1, Post.count
    assert_redirected_to blog_post_path(:id => assigns(:post))
  end

  def test_show_post
    get :show, :id => @post, :blog_id => @post.blog
    assert_response :success
  end

  def test_get_edit
    get :edit, :id => @post, :blog_id => @post.blog
    assert_response :success
  end
  
  def test_update_post
    put :update, :id => @post, :blog_id => @post.blog, :post => @valid_post
    assert_redirected_to blog_post_path(:id => assigns(:post))
  end
  
  def test_destroy_post
    old_count = Post.count
    delete :destroy, :id => @post, :blog_id => @post.blog
    assert_equal old_count-1, Post.count
    assert_redirected_to blog_posts_path
  end

  def test_unauthorized_redirected
    # Deauthorize user
    @request.session[:user_id] = nil
    [:index, :new, :show, :edit].each do |descriptor|
      get descriptor
      assert_response :redirect
      assert_redirected_to :controller => "user", :action => "login"
    end
  end
    
  def test_catch_blog_id_mismatch
    # Be some other user.
    @request.session[:user_id] = 2
    put :update, :id => @post, :blog_id => @post.blog, :post => @valid_post
    assert_response :redirect
    assert_redirected_to hub_url
    assert_equal "That isn't your blog!", flash[:notice]
  end
  
  def test_post_blog_mismatch
    wrong_post = posts(:two)  # Post exists, but belongs to wrong blog.
    get :edit, :id => wrong_post, :blog_id => @post.blog
    assert_response :redirect
    assert_redirected_to hub_url
    assert_equal "That isn't your blog post!", flash[:notice]
  end
end
