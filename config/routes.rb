Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#map'
  resources :sections, only: [:index, :show, :create, :destroy]
  resources :point_of_interest, only: [:index ,:create, :show, :destroy]
  devise_for :users, controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"}
end
