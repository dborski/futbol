require 'CSV'
require_relative 'collectable'

class Team
  include Collectable

  attr_reader :team_id, :franchise_id, :team_name,
              :abbreviation, :stadium, :link

  def initialize(team_details)
    @team_id = team_details[:team_id]
    @franchise_id = team_details[:franchiseid]
    @team_name = team_details[:teamname]
    @abbreviation = team_details[:abbreviation]
    @stadium = team_details[:stadium]
    @link = team_details[:link]
  end
end
