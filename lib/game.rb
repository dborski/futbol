require 'CSV'
require_relative 'collectable'

class Game
  include Collectable

  attr_reader :game_id, :season,
              :type, :date_time,
              :away_team_id, :home_team_id,
              :away_goals, :home_goals,
              :venue, :venue_link

  def initialize(game_details)
    @game_id = game_details[:game_id].to_i
    @season = game_details[:season]
    @type = game_details[:type]
    @date_time = game_details[:date_time]
    @away_team_id = game_details[:away_team_id].to_i
    @home_team_id = game_details[:home_team_id].to_i
    @away_goals = game_details[:away_goals].to_i
    @home_goals = game_details[:home_goals].to_i
    @venue = game_details[:venue]
    @venue_link = game_details[:venue_link]
  end
end
