$(document).ready(function() {
  var makeVideoPlayer;
  var x = window.location.href;
  var i = x.indexOf("groups/");
  var groupId = x.substring(i+7,x.length);
  var isPlaying = false
  window.ytPlayerLoaded = false;
  makeVideoPlayer = function(video) {
    var player_wrapper;
    if (!window.ytPlayerLoaded) {
      player_wrapper = $('.video-player-wrapper h1');
      player_wrapper.append('<div id="ytPlayer"><p>Loading player...</p></div>');
      window.ytplayer = new YT.Player('ytPlayer', {
        width: '100%',
        height: player_wrapper.width() / 1.777777777,
        videoId: video,
        playerVars: {
          wmode: 'opaque',
          autoplay: 1,
          modestbranding: 1
        },
        events: {
          'onReady': function() {
            return window.ytPlayerLoaded = true;
          },
          'onError': function(errorCode) {
            return alert("We are sorry, but the following error occured: " + errorCode);
          },
          'onStateChange': function(event) {
            if (event.data == YT.PlayerState.ENDED) {
              $.ajax({
                type: 'POST',
                url: '/groups/' + groupId + '/playlist/next_song'
              }).done(function(msg){
                setTimeout(function(){
                  makeVideoPlayer($($('.video-preview')[0]).data('uid'));
                }, 500);
              });
              return false;
            };
          }
        }
      });
    } else {
      window.ytplayer.loadVideoById(video);
      window.ytplayer.playVideo();
//      window.ytplayer.pauseVideo();
    }
  };


  var run = function() {
//    $('.video-preview').first().click();
    if ($('.video-preview').length !== 0) {
      makeVideoPlayer($('.video-preview').data('uid'));
      isPlaying = true;
    }
  };

  google.setOnLoadCallback(run);

//  $('.video-preview').click(function() {
//    makeVideoPlayer($(this).data('uid'));
//  });

//  setInterval(function(){
//    $('.video-preview').off("click");
//    $('.video-preview').click(function() {
//      makeVideoPlayer($(this).data('uid'));
//    });
//  }, 1000)

  $(window).on('resize', function() {
    var player;
    player = $('#ytPlayer');
    if (player.size() > 0) {
      player.height(player.width() / 1.777777777);
    }
  });


  var x = window.location.href;
  var i = x.indexOf("groups/");
  var groupId = x.substring(i+7,x.length);
  var path = '/groups/' + groupId + '/playlist/songs/events';
  var source = new EventSource(path);
  source.addEventListener('message', function(e) {
    var songs = $.parseJSON(e.data);
    var html = '';
    $('.playlist-item').remove();

    songs.forEach(function(song) {
      html += ('<div class="playlist-item">'
        + '<div class="video-preview" data-uid='
        + song.uid +'>'
        + '<img class="image-rounded" src="http://img.youtube.com/vi/'
        + song.uid + '/1.jpg">'
        + '</div>'
        + '<div class="title">'
        + '<p>'
        + song.name
        + '</p>'
        + '</div>'
        + '<div class="upvote">'
        + '<span>vote:' + song.vote + '</span>'
        + '<a rel="nofollow" href="/songs/' + song.id
        +'/votes?upvote=true" data-remote="true" data-method="post">up</a>'
        + '<span>view:' + song.times +'</span>'
        + '</div>'
        + '</div>');
    });

    $('.playlist-items').append(html);
    if (! isPlaying) run();
  });


})