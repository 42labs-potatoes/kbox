redis_url = ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379/0/42-dj"
$redis = Redis.new(url: redis_url)
