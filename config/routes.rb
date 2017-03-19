Rails.application.routes.draw do
  #we call the resources method and pass it a symbol. this instructs Rails to create
  #post routes for creating viewing & deleting instances of Post
  resources :posts

  #We removed `get "welcome/index"` because we've declared the index view as the root view
  #we also modify the about route (get "welcome/about) to allow users to visit /about rather than /welcome/about
  get 'about' => 'welcome#about'

  get 'welcome/faq'

  root 'welcome#index'
end
