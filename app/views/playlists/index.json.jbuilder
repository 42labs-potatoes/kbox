json.array!(@playlists) do |playlist|
  json.extract! playlist, :id, :youtube_url, :group_id
  json.url playlist_url(playlist, format: :json)
end
