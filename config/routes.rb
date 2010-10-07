ActionController::Routing::Routes.draw do |map|
  map.resources :settings, :only => [:index,:update], :collection => { :validate => :get }
  map.resources :reminders, :only => [:index,:update]
  map.root :controller => "welcome", :action => "index"
end
