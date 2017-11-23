Rails.application.routes.draw do
  root to: 'links#new'

  resources :links, only: [:new, :create, :show]
end
