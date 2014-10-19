class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def events
    response.header['Content-Type'] = 'text/event-stream'
    redis_url = ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379/0/42-dj"
    redis = Redis.new(url: redis_url)
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

end
