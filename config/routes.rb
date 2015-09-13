Rails.application.routes.draw do
  root to: 'pages#map'
  resources :sections, only: [:index, :show, :create, :destroy]
  devise_for :users, controllers: {
                                  sessions: "users/sessions",
                                  registrations: "users/registrations"}
end
