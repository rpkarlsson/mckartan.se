Rails.application.routes.draw do
 root to: 'pages#map'

  # Pages
  get     "about"       => "pages#about"

  resources :sections, only: [:index, :show, :create, :destroy]

  devise_for :users, controllers: { 
                                  sessions: "users/sessions",
                                  registrations: "users/registrations"}

  get ':username', to: 'users#show', as: :user

end
