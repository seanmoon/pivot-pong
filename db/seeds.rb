# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
# <Match id: 1, winner: "Adam", loser: "Bob", created_at: "2011-07-08 00:21:06", updated_at: "2011-07-08 00:21:06", occured_at: "2011-07-07 20:20:59">
#
adam = Player.create(name: "Adam")
bob = Player.create(name: "Bob")
carol = Player.create(name: "Carol")
dave = Player.create(name: "Dave")
ed = Player.create(name: "Ed")
Match.create(winner: adam, loser: bob)
Match.create(winner: bob, loser: carol)
Match.create(winner: carol, loser: dave)
Match.create(winner: dave, loser: ed)
Match.create(winner: adam, loser: carol)
Match.create(winner: adam, loser: dave)
Match.create(winner: adam, loser: ed)
