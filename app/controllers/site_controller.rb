class SiteController < ApplicationController
  
  def index
    @title = "Welcome"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

end
