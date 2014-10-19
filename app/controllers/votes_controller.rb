class VotesController < ApplicationController

  def create
    song = Song.find(params[:song_id])
    if song && params[:upvote]
      song.votes.create(ip: request.remote_ip)
      result = Song.get_song_hash(song.playlist_id)
      # songs = Song.where(playlist_id: song.playlist_id)
      # result = []
      # songs.each do |song|
      #   song_hash = {uid: song.uid, id: song.id, name: song.name, vote: song.vote_count}
      #   result << song_hash
      # end
      $redis.publish('songs.create', result.to_json)
      render json: {message: 'upvoted!'}
    else
      render json: { message: 'upvote failed.'}
    end
  end
end