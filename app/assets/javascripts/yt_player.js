$(document).ready(function() {
  var makeVideoPlayer;
  var currentVideoIndex = 0;
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
              ++currentVideoIndex;
              makeVideoPlayer($($('.video-preview')[currentVideoIndex]).data('uid'))
            }
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
    $('.video-preview').first().click();
  };

  google.setOnLoadCallback(run);

  $('.video-preview').click(function() {
    currentVideo = $(this)
    makeVideoPlayer($(this).data('uid'));
  });

  setInterval(function(){
    $('.video-preview').off("click");
    $('.video-preview').click(function() {
      makeVideoPlayer($(this).data('uid'));
    });
  }, 1000)

  $(window).on('resize', function() {
    var player;
    player = $('#ytPlayer');
    console.log(player.height());
    if (player.size() > 0) {
      player.height(player.width() / 1.777777777);
    }
  });

})