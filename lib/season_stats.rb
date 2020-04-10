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

  def winning_percentage_by_head_coach(season_id)
    games_by_head_coach = games_by_season_id(season_id).group_by { |game| game.head_coach}

    winning_percentage_by_head_coach = {}

    games_by_head_coach.each do |key, value|
      winning_games = value.find_all {|value| value.result == "WIN"}
      if winning_games.length != 0
        value = ((winning_games.length.to_f / value.length.to_f) * 100).round(2)
        winning_percentage_by_head_coach[key] = value
      else
        winning_percentage_by_head_coach[key] = 0
      end
    end
    winning_percentage_by_head_coach
  end

  def winningest_coach(season_id)
    best_win_percentage = winning_percentage_by_head_coach(season_id).max_by { |key, value| value}
    best_win_percentage.first
  end

  def worst_coach(season_id)
    worst_win_percentage = winning_percentage_by_head_coach(season_id).max_by { |key, value| -value}
    worst_win_percentage.first
  end
end
