class ProfileController < ApplicationController
  layout  'site'
  helper :avatar, :friendship

  def index
    @title = "XploreU Profiles"
  end

  def show
    @hide_edit_links = true
    screen_name = params[:screen_name]
    @user = User.find_by_screen_name(screen_name)
    if @user
      @title = "My XploreU Profile for #{screen_name}"
      @spec = @user.spec ||= Spec.new
      @faq = @user.faq ||= Faq.new
      make_profile_vars
    else
      flash[:notice] = "No user #{screen_name} at XploreU!"
      redirect_to :action => "index"
    end
  end
end