require File.dirname(__FILE__) + '/../test_helper'
require 'friendship_controller'

# Re-raise errors caught by the controller.
class FriendshipController; def rescue_action(e) raise e end; end

class FriendshipControllerTest < Test::Unit::TestCase
  include ProfileHelper
  fixtures :users, :specs

  def setup
    @controller = FriendshipController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user       = users(:valid_user)
    @friend     = users(:friend)
    # Make sure deliveries aren't actually made!
    ActionMailer::Base.delivery_method = :test
  end
  
  def test_create
    # Log in as user and send request.
    authorize @user
    get :create, :id => @friend.screen_name
    assert_response :redirect
    assert_redirected_to profile_for(@friend)
    assert_equal "Friend request sent.", flash[:notice]
    # Log in as friend and accept request.
    authorize @friend
    get :accept, :id => @user.screen_name
    assert_redirected_to hub_url
    assert_equal "Friendship with #{@user.screen_name} accepted!",
                 flash[:notice]
  end
end