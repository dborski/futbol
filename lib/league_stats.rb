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

  def highest_average_goals
  game_team = @game_teams.max_by {|team| average_goals_per_team(team.team_id)}
  game_team_id = game_team.team_id
  team = @teams.find do |team|
    team.team_id == game_team_id
  end
  team.team_name
  end



  # def goals_by_team
  #   games_by_team = @game_teams.group_by do |game|
  #     game.team_id
  #   end
  #   games_by_team.transform_values do |group|
  #     group.map {|game| game.goals}
  #   end
  # end
  #
  # def average_num_of_goals
  #   require "pry"; binding.pry
  #   goals = 0
  #   goals_by_team.sum {|goal| goals += 1 }
  #
  #   goals / goals_by_team
  # end
end
