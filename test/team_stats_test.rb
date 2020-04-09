require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/team_stats'
require './test/test_helper'

class TeamStatsTest < Minitest::Test

  def setup
    @game_teams = GameTeam.from_csv("./test/fixtures/game_teams_truncated.csv")
    @teams = Team.from_csv("./data/teams.csv")
    @games = Game.from_csv("./test/fixtures/games_truncated.csv")
    @team_stats = TeamStats.new(@game_teams, @teams, @games)

  end

  def test_it_exists
    assert_instance_of TeamStats, @team_stats
  end

  def test_it_has_readable_attributes
    assert_equal @game_teams, @team_stats.game_teams
    assert_equal @teams, @team_stats.teams
    assert_equal @games, @team_stats.games
  end

  def test_it_can_get_team_info
    expected = {team_id: 1, franchise_id: 23,
                team_name: "Atlanta United", abbreviation: "ATL",
                link: "/api/v1/teams/1"
                }
    assert_equal expected, @team_stats.team_info(1)
  end

  def test_it_can_get_season_from_game_id
    assert_equal "20122013", @team_stats.season_from_game(2012030221)
  end

    
  end
end
