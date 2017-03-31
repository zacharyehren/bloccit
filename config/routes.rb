Rails.application.routes.draw do
  #we call the resources method and pass it a symbol. this instructs Rails to create
  #post routes for creating viewing & deleting instances of Post

#we pass resources :posts to the resources :topics block. This nests the post routes under the topics routes
  resources :topics do
    resources :posts, except: [:index]
  end

  #We create routes for new and create actions. The only hash key will prevent Rails from creating unnecessary routes
  resources :users, only: [:new, :create]

  #We removed `get "welcome/index"` because we've declared the index view as the root view
  #we also modify the about route (get "welcome/about) to allow users to visit /about rather than /welcome/about
  get 'about' => 'welcome#about'

  get 'welcome/faq'

  root 'welcome#index'
end
