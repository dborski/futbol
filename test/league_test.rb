require './lib/league'
require './test/test_helper'

class LeagueTest < Minitest::Test
  def setup
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'

    locations = {
      teams: team_path,
      game_teams: game_teams_path
    }
    @league = League.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of League, @league
  end

  def test_it_has_readable_attributes
    assert_equal './data/teams.csv', @league.teams_path
    assert_equal './data/game_teams.csv', @league.game_teams_path
  end
end
