require File.dirname(__FILE__) + '/../test_helper'
require 'community_controller'

# Re-raise errors caught by the controller.
class CommunityController; def rescue_action(e) raise e end; end

class CommunityControllerTest < Test::Unit::TestCase
  fixtures :users
  fixtures :specs
  fixtures :faqs
  
  def setup
    @controller = CommunityController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    Fixtures.create_fixtures("#{RAILS_ROOT}/test/fixtures", "geo_data")
  end

  def test_index
    get :index
    assert_response :success
  end
  
  def test_browse_default
    get :browse
    assert_response :success
  end
  
  def test_browse_success
    params = { :min_age => "60", :max_age => "80",
               :gender => "Male", :miles => "1", :zip_code => "91125",
               :commit => "Browse" }
    get :browse, params
    assert_response :success
    assert_tag "p", :content => /Found 1 match./
  end
  
  def test_browse_failure
    params = { :gender => "Female", :commit => "Browse" }
    get :browse, params
    assert_response :success
    assert_tag "p", :content => /Found 0 matches./
  end
  
  def test_search_default
    get :search
    assert_equal "Search RailsSpace", assigns(:title)
    assert_response :success
    assert_template "search"
  end
  
  def test_search_success
    get :search, :q => "*"
    assert_response :success
    assert_tag "p", :content => /Found 14 matches./
    assert_tag "p", :content => /Displaying users 1&ndash;10./
  end
  
  def test_search_failure
    get :search, :q => "unlikely_search_string"
    assert_response :success
    assert_tag "p", :content => /Found 0 matches./
  end
  #  Made obsolete by the new Ferret
  # def test_invalid_search
  #   get :search, :q => "--"
  #   assert_response :success
  #   assert_tag "p", :content => /Invalid character in search./
  # end
  
  def test_not_searching_passwords
    get :search, :q => "foobar"
    assert_response :success
    # This would find 10 matches if searching the password field.
    assert_tag "p", :content => /Found 0 matches./
  end
end
