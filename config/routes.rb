Rails.application.routes.draw do
  devise_for :users
 root to: 'pages#map'

  # Pages
  get     "about"       => "pages#about"

  resources :sections, only: [:index, :show, :create, :destroy]

end
