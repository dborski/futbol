class TeamStats

  attr_reader :game_teams, :teams, :games
  def initialize(game_teams, teams, games)
    @game_teams = game_teams
    @teams = teams
    @games = games
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

  def season_from_game(game_id)
    game = @games.find{|game| game.game_id == game_id }
    game.season
  end

  def games_played_in(team_id)
    @game_teams.select{|game| game.team_id == team_id}
  end

  def average_win_percentage(team_id)
    games_played = games_played_in(team_id)
    games_won = games_played.select{|game| game.result == "WIN"}
    win_ratio = games_won.length.to_f / games_played.length.to_f
    win_percentage = (win_ratio * 100.00).round(2)
    win_percentage
  end

  def most_goals_scored(team_id)
    high_score_game = games_played_in(team_id).max_by{|game| game.goals}
    high_score_game.goals
  end

  def fewest_goals_scored(team_id)
    low_score_game = games_played_in(team_id).min_by{|game| game.goals}
    low_score_game.goals
  end
end
