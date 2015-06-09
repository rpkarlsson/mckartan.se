Rails.application.routes.draw do
 root to: 'pages#map'

  # Pages
  get     "about"       => "pages#about"

  resources :sections, only: [:index, :show, :create]

  mount UsersEngine::Engine, at: ""

end
