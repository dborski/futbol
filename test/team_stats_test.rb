require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/team_stats'
require './test/test_helper'

class TeamStatsTest < Minitest::Test

  def setup
    @game_teams = GameTeam.from_csv("./test/fixtures/game_teams_truncated_new.csv")
    @teams = Team.from_csv("./data/teams.csv")
<<<<<<< HEAD
    @games = Game.from_csv("./test/fixtures/games_truncated.csv")
=======
    @games = Game.from_csv("./test/fixtures/game_truncated_new.csv")
>>>>>>> master
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

  def test_it_can_get_games_played_in
<<<<<<< HEAD
    assert_equal 9, @team_stats.games_played_in(6).length
    assert_equal 7, @team_stats.games_played_in(17).length
=======
    assert_equal 25, @team_stats.games_played_in(6).length
    assert_equal 25, @team_stats.games_played_in(17).length
>>>>>>> master

    @team_stats.games_played_in(6).each do |game|
      assert_instance_of GameTeam, game
    end

    @team_stats.games_played_in(6).each do |game|
      assert_equal 6, game.team_id
    end
  end

  def test_it_can_get_average_win_percentage
    assert_equal 57.14, @team_stats.average_win_percentage(17)
    assert_equal 100.00, @team_stats.average_win_percentage(6)
  end

  def test_it_can_get_most_goals_scored
    assert_equal 3, @team_stats.most_goals_scored(17)
<<<<<<< HEAD
    assert_equal 1, @team_stats.most_goals_scored(5)
  end
  def test_it_can_get_fewest_goals_scored
    assert_equal 1, @team_stats.fewest_goals_scored(17)
    assert_equal 1, @team_stats.fewest_goals_scored(6)
=======
    assert_equal 4, @team_stats.most_goals_scored(5)
  end
  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored(17)
    assert_equal 0, @team_stats.fewest_goals_scored(6)
>>>>>>> master
    assert_equal 0, @team_stats.fewest_goals_scored(5)
  end
end
