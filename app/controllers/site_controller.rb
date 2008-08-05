class SiteController < ApplicationController
  layout  'site', :except => [ :about_us, :ambassadors, :tips, :pictures, :post, :blog, :updates ]
  
  ##pages##
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
  
  def terms_and_conditions
    @title = "Terms and Conditions"
  end

  def help
    @title = "Help"
  end
  
  ##tabs##
  def about_us
  end
  
  def ambassadors
  end

  def tips
  end
  
  def pictures
  end
  
  def post
  end
  
  def blog
  end
  
  def updates
  end
  
end
