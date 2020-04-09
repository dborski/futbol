class LeagueStats

  attr_reader :game_teams, :teams
  def initialize(game_teams, teams)
    @game_teams = game_teams
    @teams = teams
  end

  # def goals_by_team(team_id)
  #   @game_teams.sum {|goals| }
  # end

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
    (total_goals_by_team_id(team_id).to_f / total_games_by_team_id(team_id).to_f).round(2)
  end

  def best_offense
    game_team = @game_teams.max_by {|team| average_goals_per_team(team.team_id)}
    game_team_id = game_team.team_id
    team = @teams.find do |team|
      team.team_id == game_team_id
    end
    team.team_name
  end

  def worst_offense
    game_team = @game_teams.min_by {|team| average_goals_per_team(team.team_id)}
    game_team_id = game_team.team_id
    team = @teams.find do |team|
      team.team_id == game_team_id
    end
    team.team_name
  end
end
