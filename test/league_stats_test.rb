require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/league_stats'
require './test/test_helper'

class LeagueStatsTest < Minitest::Test

  def setup
    @game_teams = GameTeam.from_csv("./test/fixtures/game_teams_truncated.csv")
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

  def test_goals_by_team
    assert_equal [3, 3, 2, 3, 3, 3, 4, 2, 1], @league_stats.goals_by_team[6]
  end

  def test_average_number_of_goals
    skip
    assert_equal 3.5, @league_stats.average_num_of_goals
  end
end
