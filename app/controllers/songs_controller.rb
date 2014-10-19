class SongsController < ApplicationController
  include ActionController::Live
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def index
    @songs = Song.all.order('created_at DESC')
  end

  def show
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    playlist_id = Group.find(params[:group_id]).playlist.id
    song = Song.create(uid: params[:uid], playlist_id: playlist_id)
    # unless song.errors.empty?
    @songs = Song.where(playlist_id: playlist_id)
    $redis.publish('songs.create', @songs.to_json)
    # end

    # respond_to do |format|
    #   format.js
    # end
  end

  def search
    client = YouTubeIt::OAuth2Client.new(dev_key: ENV["YOUTUBE_DEVELOPER_KEY"])
    @results = client.videos_by(query: params[:search_term]).videos
    @group_id = params[:group_id]

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_song
      @song = Song.find(params[:id])
    end
end
