ActionController::Routing::Routes.draw do |map|

  map.connect 'projects/:project_id/news/subscriptions/:action', :controller => 'subscriptions'

end
