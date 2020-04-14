require_relative 'mathable'

class LeagueStats
  include Mathable

  attr_reader :game_teams, :teams
  def initialize(game_teams, teams)
    @game_teams = game_teams
    @teams = teams
  end

  def find_by_collection(team_id, csv_header, game_teams)
    @game_teams.find_all { |team| team.send(csv_header) == team_id }
  end

  def games_by_team(team_id)
    find_by_collection(team_id, "team_id", @game_teams)
  end

  def total_games_by_team_id(team_id)
      games_by_team(team_id).length
  end

  def total_goals_by_team_id(team_id)
    games_by_team(team_id).sum { |game_team| game_team.goals }
  end

  def average_goals_per_team(team_id)
    average(total_goals_by_team_id(team_id), total_games_by_team_id(team_id))
    #(total_goals_by_team_id(team_id).to_f / total_games_by_team_id(team_id).to_f).round(2)
  end

  def best_offense
    game_team = @game_teams.max_by {|team| average_goals_per_team(team.team_id)}
    game_team_id = game_team.team_id
    find_name(game_team_id)
  end

  def worst_offense
    game_team = @game_teams.min_by {|team| average_goals_per_team(team.team_id)}
    game_team_id = game_team.team_id
    find_name(game_team_id)
  end


  def highest_scoring_visitor
    away_teams = away_games.group_by {|game| game.team_id }
    away_team_records = away_teams.transform_values do |games|
     total_games = games.length.to_f
     goals = games.sum {|games| games.goals}
     (goals / total_games)
    end
    highest_scoring = away_team_records.max_by do |team, average_goals|
     average_goals
    end
    find_name(highest_scoring.first)
  end
  def lowest_scoring_visitor
    away_teams = away_games.group_by {|game| game.team_id }
    away_team_records = away_teams.transform_values do |games|
     total_games = games.length.to_f
     goals = games.sum {|games| games.goals}
     (goals / total_games)
    end
    highest_scoring = away_team_records.min_by do |team, average_goals|
     average_goals
    end
    find_name(highest_scoring.first)
  end


  def highest_scoring_home_team
    home_team = home_games.max_by {|team| average_goals_per_team(team.team_id)}
    home_team_id = home_team.team_id
    find_name(home_team_id)
  end

  def lowest_scoring_home_team
    home_team = home_games.min_by {|team| average_goals_per_team(team.team_id)}
    home_team_id = home_team.team_id
    find_name(home_team_id)
  end

  def home_games
     @game_teams.find_all do |team|
      team.hoa == "home"
    end
  end

  def away_games
    @game_teams.find_all do |team|
      team.hoa == "away"
    end
  end

  def find_name(game_team_id)
    team = @teams.find do |team|
      team.team_id == game_team_id
    end
    team.team_name
  end
end
