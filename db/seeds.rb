# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

group1 = Group.create(name: '42Labs', public: false)
Group.create(name: 'ABC', public: false)
Group.create(name: 'AAA', public: false)
Group.create(name: 'Gloden HK')
Group.create(name: 'U wants forum')
Group.create(name: 'discuss.hk')

playlist1 = Playlist.create(group_id: group1.id, name: 'Pop')
playlist1.songs.create(uid: 'gS9o1FAszdk')
playlist1.songs.create(uid: 'qHm9MG9xw1o')