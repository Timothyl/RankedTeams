require 'httparty'
require 'pry'
require 'json'

# require 'ap'
class League
  include HTTParty
  default_params :api_key => '82ced787-5473-4e7f-938f-c35a1f628ade'
  base_uri 'https://na.api.pvp.net/api/lol/na'


  def self.champions
    get("/v1.2/champion")
  end

  def self.summoner_name name
    get("/v1.4/summoner/by-name/#{name}")
  end

  def self.summoner_id id
    get("/v1.4/summoner/#{id}")
  end

  def self.team id
    get("/v2.4/team/by-summoner/#{id}")
  end

  def self.get_roster_ids summoner, team_name
    id = League.summoner_name(summoner)[summoner]['id'].to_s
    summoners_teams = League.team(id)
    team_index = summoners_teams[id].index{|team| team['name'] == team_name}
    roster = summoners_teams[id][team_index]['roster']['memberList']
    # player_ids = ""
    player_ids_array = []
    # binding.pry
    roster.each do |player|
      # player_ids << ',' << player["playerId"].to_s
      player_ids_array << player["playerId"].to_s
    end
    # player_ids[0] = ""
    player_ids_array

  end

  def self.get_roster_names summoner, team_name
    id_array = League.get_roster_ids(summoner, team_name)
    player_names = []
    player_id_string = ""
    id_array.each do |id|
      player_id_string << ',' << id
    end
    player_id_string[0] = ""
    players = summoner_id(player_id_string)
    id_array.each do |player_id|
      player_names << players[player_id]['name']
    end
    player_names
  end


end


League.get_roster_ids('quidestpro', 'Hello Kitties On Crack')
puts League.get_roster_names('quidestpro', 'Hello Kitties On Crack')
# binding.pry
# File.open('temp.json', 'w') do |f|
#   f.write(JSON.pretty_generate(summoners_teams[id][team_index]['roster']['memberList']))
# end
