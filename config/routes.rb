Storywall::Application.routes.draw do
  root :to => 'stories#index'
  resources :stories
  devise_for :users
end
