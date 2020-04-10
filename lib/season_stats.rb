class SeasonStats

  attr_reader :game_teams, :games, :teams
  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def games_ids_by_season(season_id)
    all_games_by_id = @games.find_all { |game| game.season == season_id }
    all_games_by_id.map { |game| game.game_id }
  end

  def games_by_season_id(season_id)
    games_by_id = []
    @game_teams.each do |game|
      if games_ids_by_season(season_id).any? { |id| id == game.game_id }
        games_by_id << game
      end
    end
    games_by_id
  end

  def team_name_by_team_id
    all_teams = {}
    @teams.each { |team| all_teams[team.team_id] = team.team_name }
    all_teams
  end

  def games_by_team_name(season_id)
    games_by_id = games_by_season_id(season_id).group_by { |game| game.team_id }
    games_by_id.transform_keys(&team_name_by_team_id.method(:[]))
  end

  def games_by_head_coach(season_id)
    games_by_season_id(season_id).group_by { |game| game.head_coach }
  end

  def winning_percentage_by_head_coach(season_id)
    winning_percentage_by_head_coach = {}
    games_by_head_coach(season_id).each do |key, value|
      winning_games = value.find_all { |value| value.result == "WIN" }
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
    best_win_percentage = winning_percentage_by_head_coach(season_id).max_by { |key, value| value }
    best_win_percentage.first
  end

  def worst_coach(season_id)
    worst_win_percentage = winning_percentage_by_head_coach(season_id).max_by { |key, value| -value }
    worst_win_percentage.first
  end

  def shooting_percentage_by_team(season_id)
    most_accurate_team = {}
    games_by_team_name(season_id).each do |key, value|
      total_shots = value.sum { |value| value.shots }
      total_goals = value.sum { |value| value.goals }
      most_accurate_team[key] = ((total_goals.to_f / total_shots.to_f) * 100).round(2)
    end
    most_accurate_team
  end

  def most_accurate_team(season_id)
    best_shot_accuracy = shooting_percentage_by_team(season_id).max_by { |key, value| value }
    best_shot_accuracy.first
  end

  def least_accurate_team(season_id)
    worst_shot_accuracy = shooting_percentage_by_team(season_id).max_by { |key, value| -value }
    worst_shot_accuracy.first
  end

  def tackles_by_team(season_id)
    tackles_by_team = {}
    games_by_team_name(season_id).each do |key, value|
      total_tackles = value.sum { |value| value.tackles }
      tackles_by_team[key] = total_tackles
    end
    tackles_by_team
  end

  def most_tackles(season_id)
    most_tackles = tackles_by_team(season_id).max_by { |key, value| value }
    most_tackles.first
  end

  def fewest_tackles(season_id)
    fewest_tackles = tackles_by_team(season_id).max_by { |key, value| -value }
    fewest_tackles.first
  end
end
