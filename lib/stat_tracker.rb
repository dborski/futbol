require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'game_stats'
require_relative 'season_stats'
require_relative 'league_stats'
require_relative 'team_stats'
require_relative 'collectable'

class StatTracker
  include Collectable

  attr_reader :games, :teams, :game_teams,
              :league_stats, :team_stats, :game_stats

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    teams_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]
    StatTracker.new(game_path, teams_path, game_teams_path)
  end

  def initialize(game_path, teams_path, game_teams_path)
    @games = create_objects(game_path, Game)
    @teams = create_objects(teams_path, Team)
    @game_teams = create_objects(game_teams_path, GameTeam)
    @game_stats = GameStats.new(@games)
    @league_stats = LeagueStats.new(@game_teams, @teams)
    @season_stats = SeasonStats.new(@game_teams, @games, @teams)
    @team_stats = TeamStats.new(@game_teams, @teams, @games)
  end

  def count_of_teams
    @teams.length
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def team_info(team_id)
    @team_stats.team_info(team_id)
  end

  def best_season(team_id)
    @team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @team_stats.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @team_stats.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_stats.fewest_goals_scored(team_id)
  end

  def rival(team_id)
    @team_stats.rival(team_id)
  end

  def favorite_opponent(team_id)
    @team_stats.favorite_opponent(team_id)
  end

  def winningest_coach(season_id)
    @season_stats.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    @season_stats.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    @season_stats.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id)
    @season_stats.least_accurate_team(season_id)
  end

  def most_tackles(season_id)
    @season_stats.most_tackles(season_id)
  end

  def fewest_tackles(season_id)
    @season_stats.fewest_tackles(season_id)
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end
end
