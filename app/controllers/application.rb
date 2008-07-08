# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include ApplicationHelper
 
  before_filter :check_authorization
  
  # Log a user in by authorization cookie if necessary.
  def check_authorization
    authorization_token = cookies[:authorization_token]
    if authorization_token and not logged_in?
      user = User.find_by_authorization_token(authorization_token)
      user.login!(session) if user
    end
  end
  
  # Return true if a parameter corresponding to the given symbol was posted.
  def param_posted?(sym)
    request.post? and params[sym]
  end
  
  # Protect a page from unauthorized access.
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "Please log in first"
      redirect_to :controller => "user", :action => "login"
      return false
    end
  end
    
  def make_profile_vars
    @spec = @user.spec ||= Spec.new
    @faq = @user.faq ||= Faq.new 
    @blog = @user.blog ||= Blog.new
    @posts = Post.paginate_by_blog_id(@blog.id, :page => params[:page], :per_page => 3)
    @pages = @posts.total_entries
    #@pages, @posts = paginate(@blog.posts, :per_page => 3)
  end
end