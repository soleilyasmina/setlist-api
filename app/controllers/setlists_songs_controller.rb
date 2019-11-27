class SetlistsSongsController < ApplicationController
  before_action :get_song
  before_action :get_setlist

  def add_song
    if @setlist.songs.include?(@song)
      render json: { errors: ['Song is already in setlist.'] }, status: :conflict
    else
      @setlist.songs << @song
      render json: @setlist, include: :songs, status: :ok
    end
  end

  def remove_song
    if !@setlist.songs.include?(@song)
      render json: { errors: ['Song is not in setlist.'] }, status: :conflict
    else
      @setlist.songs.delete(@song)
      render json: @setlist, include: :songs, status: :ok
    end
  end

  private
    def get_song
      @song = Song.find(params[:song_id])
    end

    def get_setlist
      @setlist = Setlist.find(params[:setlist_id])
    end
end
