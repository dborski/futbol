require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/league_stats'
require './test/test_helper'

class LeagueStatsTest < Minitest::Test

  def setup
    @game_teams = GameTeam.from_csv("./test/fixtures/game_teams_truncated_new.csv")
    @teams = Team.from_csv("./data/teams.csv")
    @league_stats = LeagueStats.new(@game_teams, @teams)
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_it_has_readable_attributes
    assert_equal @game_teams, @league_stats.game_teams
    assert_equal @teams, @league_stats.teams
  end

  def test_can_find_by_collection
    assert_instance_of Array, @league_stats.find_by_collection(6, "team_id", @game_teams)
    assert_equal 24, @league_stats.find_by_collection(6, "team_id", @game_teams).count
  end

  def test_it_can_return_games_by_team
    assert_equal 24, @league_stats.games_by_team(6).count
  end

  def test_it_can_return_average_goals_per_team
    assert_equal 1.96, @league_stats.average_goals_per_team(6)
  end

  def test_it_can_return_best_offense
    assert_equal "New England Revolution", @league_stats.best_offense
  end

  def test_it_can_return_worst_offense
    assert_equal "FC Cincinnati", @league_stats.worst_offense
  end

  def test_it_can_return_highest_scoring_visitor
    assert_equal "New England Revolution", @league_stats.highest_scoring_visitor
  end

  def test_it_can_return_lowest_scoring_visitor
    assert_equal "FC Cincinnati", @league_stats.lowest_scoring_visitor
  end

  def test_it_can_return_highest_scoring_home_team
    assert_equal "New England Revolution", @league_stats.highest_scoring_home_team
  end

  def test_it_can_return_lowest_scoring_home_team
    assert_equal "FC Cincinnati", @league_stats.lowest_scoring_home_team
  end
end
