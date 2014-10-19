# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

group1 = Group.create(name: '42Labs', public: false)
group2 = Group.create(name: 'Google', public: false)
group3 = Group.create(name: 'Microsoft', public: false)
group4 = Group.create(name: 'Yahoo')
group5 = Group.create(name: '37Signals')
group6 = Group.create(name: 'HashRocket')

playlist1 = Playlist.create(group_id: group1.id, name: 'Pop')
playlist2 = Playlist.create(group_id: group2.id, name: 'Pop')
playlist3 = Playlist.create(group_id: group3.id, name: 'Pop')
playlist4 = Playlist.create(group_id: group4.id, name: 'Pop')
playlist5 = Playlist.create(group_id: group5.id, name: 'Pop')
playlist6 = Playlist.create(group_id: group6.id, name: 'Pop')
playlist1.songs.create(uid: 'gS9o1FAszdk')
playlist1.songs.create(uid: 'qHm9MG9xw1o')
playlist2.songs.create(uid: 'gS9o1FAszdk')
playlist2.songs.create(uid: 'qHm9MG9xw1o')
playlist3.songs.create(uid: 'gS9o1FAszdk')
playlist3.songs.create(uid: 'qHm9MG9xw1o')
playlist4.songs.create(uid: 'gS9o1FAszdk')
playlist4.songs.create(uid: 'qHm9MG9xw1o')
playlist5.songs.create(uid: 'gS9o1FAszdk')
playlist5.songs.create(uid: 'qHm9MG9xw1o')
playlist6.songs.create(uid: 'gS9o1FAszdk')
playlist6.songs.create(uid: 'qHm9MG9xw1o')