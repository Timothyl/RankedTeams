require_relative 'League'
require 'json'
require 'pry'

class Team
  attr_reader :team
  def initialize summoner, team_name
    summoner.downcase!
    summoner_id = League.summoner_name(summoner)[summoner]['id'].to_s
    summoners_teams = League.team(summoner_id)
    team_index = summoners_teams[summoner_id].index{|team| team['name'] == team_name}
    @team = summoners_teams[summoner_id][team_index]
  end


  def get_roster_ids
    roster = team['roster']['memberList']
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

  def get_roster_names
    id_array = get_roster_ids
    player_names = []
    player_id_string = ""
    id_array.each do |id|
      player_id_string << ',' << id
    end
    player_id_string[0] = ""
    players = League.summoner_id(player_id_string)
    id_array.each do |player_id|
      player_names << players[player_id]['name']
    end
    player_names
  end

  def match_info match_id
    match = get("/v2.2/match/#{match_id}")
    File.open('temp.json', 'w') do |f|
      f.write(JSON.pretty_generate(match))
    end
  end
end

t = Team.new('Quidestpro', 'Calypso')
puts t.get_roster_names
