class SeasonStats

  attr_reader :game_teams, :games, :teams
  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def games_ids_by_season(season_id)
    all_games_by_id = @games.find_all {|game| game.season == season_id}
    all_games_by_id.map { |game| game.game_id}
  end

  def games_by_season_id(season_id)
    games_by_id = []
    @game_teams.each do |game|
      if games_ids_by_season(season_id).any? { |id| id == game.game_id}
        games_by_id << game
      end
    end
    games_by_id
  end

  def winningest_coach(season_id)
    #finding all games by season id
    require "pry"; binding.pry
    #find winningest coach by that season
  end
end
