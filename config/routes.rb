Rails.application.routes.draw do
  #we call the resources method and pass it a symbol. this instructs Rails to create
  #post routes for creating viewing & deleting instances of Post

#we pass resources :posts to the resources :topics block. This nests the post routes under the topics routes
  resources :topics do
    resources :posts, except: [:index]
  end

#we use `only: []` because we don't want to create any /posts/:id routes, just posts/:post_id/comments
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    #these two lines create POST routes at the URL 'posts/:id/up-vote' and posts/:id/down-vote.
    #the as key-value pairs at the end stipulate the method names which will be associated with these routes: up_vote_path & down_vote_path
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end



  #We create routes for new and create actions. The only hash key will prevent Rails from creating unnecessary routes
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  #We removed `get "welcome/index"` because we've declared the index view as the root view
  #we also modify the about route (get "welcome/about) to allow users to visit /about rather than /welcome/about
  get 'about' => 'welcome#about'

  get 'welcome/faq'

  root 'welcome#index'

  #sets the users/confirm path to the users confirm#action in the controller
  post 'users/confirm' => 'users#confirm'
end
