require_relative 'mathable'

class TeamStats
  include Mathable

  attr_reader :game_teams, :teams, :games
  def initialize(game_teams, teams, games)
    @game_teams = game_teams
    @teams = teams
    @games = games
  end

  def team_info(id)
    team = @teams.find{|team| team.team_id == id}
    team_info = {}
    team_info["team_id"] = team.team_id
    team_info["franchise_id"] = team.franchise_id
    team_info["abbreviation"] = team.abbreviation
    team_info["team_name"] = team.team_name
    team_info["link"] = team.link
    team_info
  end

  def season_from_game(game_id, team_id)
    game_team = @game_teams.find do |game_team|
      game_team.game_id == game_id && game_team.team_id == team_id
    end
    game_season = {}
    game = @games.find{|game| game.game_id == game_id }
    game_season[game.season] = game_team
    game_season
  end

  def games_played_in(team_id)
    @game_teams.select{|game| game.team_id == team_id}
  end

  def average_win_percentage(team_id)
    games_played = games_played_in(team_id)
    games_won = games_played.select{|game| game.result == "WIN"}.length
    percent(games_won, games_played)
    # win_ratio = games_won.length.to_f / games_played.length.to_f
    # win_percentage = win_ratio.round(2)
    # win_percentage
  end

  def most_goals_scored(team_id)
    high_score_game = games_played_in(team_id).max_by{|game| game.goals}
    high_score_game.goals
  end

  def fewest_goals_scored(team_id)
    low_score_game = games_played_in(team_id).min_by{|game| game.goals}
    low_score_game.goals
  end

  def games_by_season(team_id)
    games_by_season = {}
    games = games_played_in(team_id).map do |game|
      season_from_game(game.game_id, team_id)
    end
    games.each do |game|
      unless games_by_season[game.keys[0]]
        games_by_season[game.keys[0]] = []
      end
      games_by_season[game.keys[0]] << game.values[0]
    end
    games_by_season
  end

  def win_percentage_by_season(team_id)
    games_by_season(team_id).transform_values do |games|
      total_games = games
      wins = games.select{|game| game.result == "WIN"}.length
      percent(wins, total_games)
    end
  end

  def best_season(team_id)
    win_percentages = win_percentage_by_season(team_id)
    best_season = win_percentages.max_by do |season,win_percentage|
      win_percentage
    end
    best_season[0]
  end

  def worst_season(team_id)
    win_percentages = win_percentage_by_season(team_id)
    worst_season = win_percentages.min_by do |season,win_percentage|
      win_percentage
    end
    worst_season[0]
  end

  def find_opponent_games(game_id, team_id)
    game_teams.find do |game|
      game.game_id == game_id && game.team_id != team_id
    end
  end

  def games_by_opponent(team_id)
    games = games_played_in(team_id)
    opponent_games = games.map do |game|
      find_opponent_games(game.game_id, team_id)
    end
    opponent_games.group_by { |game| game.team_id }
  end

  def opponent_win_percentages(team_id)
    games_by_opponent(team_id).transform_values do |games|
      total_games = games
      wins = games.select{|game| game.result == "WIN"}.length
      percent(wins, total_games)
    end
  end

  def rival(team_id)
    opponent_wins = opponent_win_percentages(team_id)
    rival_wins = opponent_wins.max_by{|key, value| value }
    Team.find_name(rival_wins.first)
  end

  def favorite_opponent(team_id)
    opponent_wins = opponent_win_percentages(team_id)
    favorite_wins = opponent_wins.min_by {|key, value| value }
    Team.find_name(favorite_wins.first)
  end
end
