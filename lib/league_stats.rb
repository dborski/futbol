class LeagueStats

  attr_reader :game_teams, :teams
  def initialize(game_teams, teams)
    @game_teams = game_teams
    @teams = teams
  end

  def goals_by_team
    games_by_team = @game_teams.group_by do |game|
      game.team_id
    end
    games_by_team.transform_values do |group|
      group.map {|game| game.goals}
    end
  end

  def average_num_of_goals
    @game_teams
  end
end
