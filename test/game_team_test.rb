require './lib/team'
require './lib/game'
require './lib/game_team'
require './test/test_helper'
require './lib/collectable'

class GameTeamTest < Minitest::Test
  include Collectable

  def setup
    @game_team = GameTeam.new({game_id: 2012030221, team_id: "3",
      hoa: "away", result: "LOSS", head_coach: "John Tortorella", goals: 2,
      shots: 8, tackles: 44
      })
    @game_teams = create_objects("./test/fixtures/game_teams_truncated.csv", GameTeam)

  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_readable_attributes
    assert_equal 2012030221, @game_team.game_id
    assert_equal "3", @game_team.team_id
    assert_equal "away", @game_team.hoa
    assert_equal "LOSS", @game_team.result
    assert_equal "John Tortorella", @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 8, @game_team.shots
    assert_equal 44, @game_team.tackles
  end

  def test_it_can_create_game_team_objects_from_CSV
    assert_instance_of GameTeam, @game_teams[0]
    assert_instance_of GameTeam, @game_teams[-1]
    assert_equal 2012030221, @game_teams[0].game_id
    assert_equal "3", @game_teams[0].team_id
    assert_equal "away", @game_teams[0].hoa
    assert_equal "LOSS", @game_teams[0].result
    assert_equal "John Tortorella", @game_teams[0].head_coach
    assert_equal 2, @game_teams[0].goals
    assert_equal 8, @game_teams[0].shots
    assert_equal 44, @game_teams[0].tackles
  end

  def test_it_can_create_array_of_all_game_teams
    assert_instance_of Array, @game_teams
    assert_equal 34, @game_teams.length
    assert_instance_of GameTeam, @game_teams.first
  end
end
