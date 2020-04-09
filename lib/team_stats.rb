class TeamStats

  attr_reader :game_teams, :teams
  def initialize(game_teams, teams)
    @game_teams = game_teams
    @teams = teams
  end

  def team_info(id)
    team = @teams.find{|team| team.team_id == id}
    team_info = {}
    team_info[:team_id] = team.team_id
    team_info[:franchise_id] = team.franchise_id
    team_info[:abbreviation] = team.abbreviation
    team_info[:team_name] = team.team_name
    team_info[:link] = team.link
    team_info
  end
end
