Rails.application.routes.draw do
  resources :setlists do
    put '/songs/:song_id', to: 'setlists_songs#add_song'
    delete '/songs/:song_id', to: 'setlists_songs#remove_song'
  end

  resources :songs
end
