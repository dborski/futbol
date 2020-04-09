require 'CSV'

class GameTeam
  @@all = []
  attr_reader :game_id, :team_id, :hoa, :result, :head_coach,
              :goals, :shots, :tackles

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol )
    @@all = csv.map{|row| GameTeam.new(row)}
  end

  def self.all
    @@all
  end

  def initialize(game_team_details)
    @game_id = game_team_details[:game_id].to_i
    @team_id = game_team_details[:team_id].to_i
    @hoa = game_team_details[:hoa]
    @result = game_team_details[:result]
    @head_coach = game_team_details[:head_coach]
    @goals = game_team_details[:goals].to_i
    @shots = game_team_details[:shots].to_i
    @tackles = game_team_details[:tackles].to_i
  end
end
