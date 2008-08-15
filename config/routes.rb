ActionController::Routing::Routes.draw do |map|
  #Default route.
  map.root :controller => 'user', :action => 'home'
  
  #Blog resources.
  map.resources :blogs do |blog| 
    blog.resources :posts do |post| 
      post.resources :comments 
    end 
  end
  
  map.contact '/contact', :controller => 'contacts', :action => 'new', :conditions => {:method => :get}
  map.connect '/contact/create', :controller => 'contacts', :action => 'create', :conditions => {:method => :post}
  
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Named routes.
  map.hub 'user', :controller => 'user', :action => 'index'
  map.profile 'profile/:screen_name', :controller => 'profile', :action => 'show'
  
  # REST resources.
  map.resources :specs
  
  #Forums resources.
  map.resources :forums
  
  map.namespace(:admin) do |admin|
    admin.resources :forums
  end
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end