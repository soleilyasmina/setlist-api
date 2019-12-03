Rails.application.routes.draw do
  resources :projects do
    resources :members, except: [:show]
    resources :setlists
    resources :songs
  end

  put '/setlists/:setlist_id/songs/:song_id', to: 'setlists_songs#add_song'
  delete '/setlists/:setlist_id/songs/:song_id', to: 'setlists_songs#remove_song'

  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'
  get '/auth/verify', to: 'authentication#verify'
  put '/auth/update', to: 'authentication#update'
end
