Rails.application.routes.draw do
  get '/' => 'buttons#show', :as => 'button'
  put '/' => 'buttons#push', :as => 'push_button'
  root :to => "buttons#show"
end
