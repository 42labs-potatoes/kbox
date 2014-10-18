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
    @song = Song.create(uid: params[:uid], playlist_id: playlist_id)
    $redis.publish('songs.create', @song.to_json)

    # respond_to do |format|
    #   format.js
    # end
  end

  def search
    client = YouTubeIt::OAuth2Client.new(dev_key: 'AIzaSyAfdk9o_YixCCW0SuKZO4DWcoARtXvnjps')
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


  def events
    response.header['Content-Type'] = 'text/event-stream'
    redis = Redis.new
    redis.subscribe('songs.create') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info 'Stream closed.'
  ensure
    redis.quit
    response.stream.close
  end

  private
    def set_song
      @song = Song.find(params[:id])
    end
end
