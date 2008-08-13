class SiteController < ApplicationController
  layout  'site', :except => [ :hot_topics, :ambassadors, :tips, :pictures, :post, :blog, :updates ]
  
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
  
  def about_us
    @title = "About XploreU"
  end
  
  def terms_and_conditions
    @title = "Terms and Conditions"
  end

  def help
    @title = "Help"
  end
  
  def hot_topics_info
    @title = "Hot Topics"
  end
  
  def life_saving_tips
    @title = "Life Saving Tips"
  end
  
  ##tabs##
  def hot_topics
  end
  
  def ambassadors
  end

  def tips
  end
  
  def pictures
  end
  
  def blog
  end
  
  def updates
  end
  
end
