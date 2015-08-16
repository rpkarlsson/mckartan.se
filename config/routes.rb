Rails.application.routes.draw do
 root to: 'pages#map'

  # Pages
  get     "about"       => "pages#about"

  resources :sections, only: [:index, :show, :create, :destroy]

  mount UsersEngine::Engine, at: ""

end
