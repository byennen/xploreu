class UserController < ApplicationController
  include ApplicationHelper
  layout  'site', :except => [ :hom ]
  helper :profile, :avatar
  before_filter :protect, :only => [:index, :edit]
  
  def home
    @title = "Welcome to XploreU"
    render :layout => 'home'
    if request.get?    
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name,
                                                   @user.password) 
      if user
        user.login!(session)
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies)
        notice_stickie("User #{user.screen_name} logged in!")
        # redirect_to :action => "index", :controller => "user"
      else 
        @user.clear_password!
        error_stickie("Invalid screen name/password combination")
      end
    end
  end
  
  def index
    @title = "XploreU User Hub"
    @user = User.find(session[:user_id])
    make_profile_vars
  end

  def register
    @title = "Register"
    if param_posted?(:user)
      @user = User.new(params[:user])
      if @user.save 
        @user.login!(session)
        notice_stickie("User #{@user.screen_name} created!")
        redirect_to_forwarding_url
      else
        @user.clear_password!
      end
    end
  end

  def login
    @title = "Log in to XploreU"
    if request.get?    
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name,
                                                   @user.password) 
      if user
        user.login!(session)
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies)
        notice_stickie("User #{user.screen_name} logged in!")
        redirect_to_forwarding_url
      else 
        @user.clear_password!
        error_stickie("Invalid screen name/password combination")
      end
    end
  end
  
  def logout
    User.logout!(session, cookies)
    notice_stickie("Logged out")
    redirect_to :action => "home", :controller => "user"
  end
  
  # Edit the user's basic info.
  def edit
    @title = "Edit basic info"
    @user = User.find(session[:user_id])   
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
      when "email"
        try_to_update @user, attribute
      when "password"
        if @user.correct_password?(params)
          try_to_update @user, attribute
        else
          @user.password_errors(params)
        end  
      end
    end
    # For security purposes, never fill in password fields.
    @user.clear_password!
  end

  private
  
  # Redirect to the previously requested URL (if present).
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :controller => "user", :action => "index"
    end
  end
  
  # Return a string with the status of the remember me checkbox.
  def remember_me_string
    cookies[:remember_me] || "0"
  end
  
  # Try to update the user, redirecting if successful.
  def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      warning_stickie("User #{attribute} updated.")
      redirect_to :action => "index"
    end
  end
end