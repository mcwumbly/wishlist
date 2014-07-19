Rails.application.routes.draw do

  get '/' => 'home#index'

  get '/register' => 'users#new'
  post '/register' => 'users#create'
  get '/users/:id' => 'users#show'
  get '/users/:id/edit' => 'users#edit'
  put '/users/:id' => 'users#update'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  get '/lists/new' => 'lists#new'
  post '/lists' => 'lists#create'
  get '/lists/:id' => 'lists#show'
  get '/lists/:id/edit' => 'lists#edit'
  put '/lists/:id' => 'lists#update'

  post '/lists/:id/items' => 'lists#add_item'

  post '/lists/:id/responses' => 'lists#add_response'

end
