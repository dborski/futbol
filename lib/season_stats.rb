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

    games_by_head_coach(season_id).each do |coach, games|
      winning_games = games.find_all { |game| game.result == "WIN" }
      if winning_games.length != 0
        games = ((winning_games.length.to_f / games.length.to_f) * 100).round(2)
        winning_percentage_by_head_coach[coach] = games
      else
        winning_percentage_by_head_coach[coach] = 0
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
    team_shooting_perctage = {}
    games_by_team_name(season_id).each do |team, games|
      total_shots = games.sum { |game| game.shots }
      total_goals = games.sum { |game| game.goals }
      team_shooting_perctage[team] = ((total_goals.to_f / total_shots.to_f) * 100).round(2)
    end
    team_shooting_perctage
  end

  def most_accurate_team(season_id)
    best_shot_accuracy = shooting_percentage_by_team(season_id).max_by { |key, value| value }
    best_shot_accuracy.first
  end

  def least_accurate_team(season_id)
    worst_shot_accuracy = shooting_percentage_by_team(season_id).min_by { |key, value| value }
    worst_shot_accuracy.first
  end

  def tackles_by_team(season_id)
    tackles_by_team = {}
    games_by_team_name(season_id).each do |team, games|
      total_tackles = games.sum { |game| game.tackles }
      tackles_by_team[team] = total_tackles
    end
    tackles_by_team
  end

  def most_tackles(season_id)
    most_tackles = tackles_by_team(season_id).max_by { |team, tackles| tackles }
    most_tackles.first
  end

  def fewest_tackles(season_id)
    fewest_tackles = tackles_by_team(season_id).min_by { |team, tackles| tackles }
    fewest_tackles.first
  end
end
