class AvatarController < ApplicationController
  layout  'site'
  before_filter :protect

  def index
    redirect_to hub_url
  end

  def upload
    @title = "Upload Your Photo"
    @user = User.find(session[:user_id])
    if param_posted?(:avatar)
      image = params[:avatar][:image]
      @avatar = Avatar.new(@user, image)
      if @avatar.save
        flash[:notice] = "Your photo has been uploaded."
        redirect_to hub_url
      end
    end
  end
  
  # Delete the avatar.
  def delete
    user = User.find(session[:user_id])
    user.avatar.delete
    flash[:notice] = "Your photo has been deleted."
    redirect_to hub_url
  end
end