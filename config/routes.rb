Rails.application.routes.draw do
  root to: 'pages#map'
  devise_for :users, controllers: {
                                  sessions: "users/sessions",
                                  registrations: "users/registrations"}

  resources :sections, only: [:index, :show, :create, :destroy]
  get ':username', to: 'users#show', as: :user

end
