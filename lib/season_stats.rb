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
    ### game teams by coach, coach as a key, all game_team objects as values
    ### win percentage of values array
    ### wing percentage method as own method
    winnings_games = games_by_season_id(season_id).find_all { |game| game.result == "WIN"}
    winning_coach = winnings_games.max_by { |game| game.head_coach}
    winning_coach
    require "pry"; binding.pry
  end
  #
  # def worst_coach(season_id)
  #   losing_games = games_by_season_id(season_id).find_all { |game| game.result == "LOSS"}
  #   losing_coach = losing_games.max_by { |game| game.head_coach}
  #   losing_coach.head_coach
  #   require "pry"; binding.pry
  # end
end
