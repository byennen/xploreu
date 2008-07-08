ActionController::Routing::Routes.draw do |map|
  map.resources :blogs do |blog| 
    blog.resources :posts do |post| 
      post.resources :comments 
    end 
  end
  
  map.contact '/contact', :controller => 'contacts', :action => 'new', :conditions => {:method => :get}
  map.connect '/contact/create', :controller => 'contacts', :action => 'create', :conditions => {:method => :post}
  
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.root :controller => 'site', :action => 'index'
  #map.connect '', :controller => 'site', :action => 'index', :id => nil
  
  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Named routes.
  map.hub 'user', :controller => 'user', :action => 'index'
  map.profile 'profile/:screen_name', :controller => 'profile', :action => 'show'
  
  # REST resources.
  map.resources :specs
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end