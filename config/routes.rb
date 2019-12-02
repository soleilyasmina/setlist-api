Rails.application.routes.draw do
  resources :projects do
    resources :members, except: [:show]
  end

  resources :setlists do
    put '/songs/:song_id', to: 'setlists_songs#add_song'
    delete '/songs/:song_id', to: 'setlists_songs#remove_song'
  end
  resources :songs


  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'
  get '/auth/verify', to: 'authentication#verify'
  put '/auth/update', to: 'authentication#update'
end
