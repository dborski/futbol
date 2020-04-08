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
end
