
var x = window.location.href;
var i = x.indexOf("groups/");
var groupId = x.substring(i+7,x.length);
var path = '/groups/' + groupId + '/playlist/songs/events';
var source = new EventSource(path);
source.addEventListener('message', function(e) {
  var song = $.parseJSON(e.data)
  var html = '<div class="playlist-item">'
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
    + 'Up'
    + '</div>'
    + '</div>'

  $('.playlist-items').append(html);
});


