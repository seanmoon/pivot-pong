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
Match.create(:winner => "Adam", :loser => "Bob")
Match.create(:winner => "Bob", :loser => "Carol")
Match.create(:winner => "Carol", :loser => "Dave")
Match.create(:winner => "Dave", :loser => "Ed")
Match.create(:winner => "Adam", :loser => "Carol")
Match.create(:winner => "Adam", :loser => "Dave")
Match.create(:winner => "Adam", :loser => "Ed")
