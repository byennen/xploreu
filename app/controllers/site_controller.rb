class SiteController < ApplicationController
  layout  'site', :except => [ :index ]
  
  def index
    @title = "Welcome to XploreU"
    @menu_tabs = ["Recent Activity", "Contact", "Networking", "Advertise", "XU Beta", "Photos", "Blog"] 
    render :layout => 'home'
  end

  def xplore
    @title = "Xplore"
  end
  
  def points_and_rewards
    @title = "Points and Rewards"
  end
  
  def study_abroad
    @title = "Study Abroad"
  end
  
  def forums
    @title = "Forums"
  end
  
  def about
    @title = "About"
  end
  
  def terms_and_conditions
    @title = "Terms and Conditions"
  end

  def help
    @title = "Help"
  end

end
