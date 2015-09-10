require 'httparty'
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

  def self.match_history summoner_id
    get("/v2.2/matchhistory/#{summoner_id}")
  end
end

# name = "thememan"
# summoner = League.summoner_name(name)
# id = summoner[name]["id"]
# history =  League.match_history(id)
# # puts history
# history = history["matches"][0]
# match = League.match_info(history['matchId'])
# binding.pry
# File.open('temp.json', 'w') do |f|
#   f.write(JSON.pretty_generate(match))
# end

# League.get_roster_ids('quidestpro', 'Hello Kitties On Crack')
# puts League.get_roster_names('quidestpro', 'Hello Kitties On Crack')
# binding.pry
# File.open('temp.json', 'w') do |f|
#   f.write(JSON.pretty_generate(summoners_teams[id][team_index]['roster']['memberList']))
# end
