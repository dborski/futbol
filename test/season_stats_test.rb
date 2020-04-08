require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/season_stats'
require './test/test_helper'

class SeasonStatsTest < Minitest::Test

  def setup
    @game_teams = GameTeam.from_csv("./test/fixtures/game_teams_truncated.csv")
    @teams = Team.from_csv("./data/teams.csv")
    @season_stats = SeasonStats.new(@game_teams, @teams)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_it_has_readable_attributes
    assert_equal @game_teams, @season_stats.game_teams
    assert_equal @teams, @season_stats.teams
  end
end
