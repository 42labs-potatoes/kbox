
var x = window.location.href;
var i = x.indexOf("groups/");
var groupId = x.substring(i+7,x.length);
var path = '/groups/' + groupId + '/playlist/songs/events';
var source = new EventSource(path);
source.addEventListener('message', function(e) {
  var songs = $.parseJSON(e.data);
  var html = '';
  console.log(songs);
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
  console.log(html);

  $('.playlist-items').append(html);
});


