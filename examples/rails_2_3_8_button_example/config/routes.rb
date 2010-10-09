ActionController::Routing::Routes.draw do |map|
  map.button '/', :controller => 'buttons', :action => 'show', :method => :get
  map.push_button '/push', :controller => 'buttons', :action => 'push', :method => :put
end
