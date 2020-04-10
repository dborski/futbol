require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/team_stats'
require './test/test_helper'

class TeamStatsTest < Minitest::Test

  def setup
    @game_teams = GameTeam.from_csv("./test/fixtures/game_teams_truncated_new.csv")
    @teams = Team.from_csv("./data/teams.csv")
    @games = Game.from_csv("./test/fixtures/game_truncated_new.csv")
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

  def test_it_can_get_season_and_game_from_game_id
    game3 = mock
    @games.stubs(:find).returns(game3)
    game3.stubs(:season).returns("20122013")
    expected = {"20122013" => game3}
    assert_equal expected, @team_stats.season_from_game(2012020004)
  end

  def test_it_can_get_games_played_in
    assert_equal 24, @team_stats.games_played_in(6).length
    assert_equal 24, @team_stats.games_played_in(17).length

    @team_stats.games_played_in(6).each do |game|
      assert_instance_of GameTeam, game
    end

    @team_stats.games_played_in(6).each do |game|
      assert_equal 6, game.team_id
    end
  end

  def test_it_can_get_average_win_percentage
    assert_equal 33.33, @team_stats.average_win_percentage(17)
    assert_equal 37.50, @team_stats.average_win_percentage(6)
  end

  def test_it_can_get_most_goals_scored
    assert_equal 3, @team_stats.most_goals_scored(17)
    assert_equal 4, @team_stats.most_goals_scored(5)
  end
  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored(17)
    assert_equal 0, @team_stats.fewest_goals_scored(6)
    assert_equal 0, @team_stats.fewest_goals_scored(5)
  end

  def test_it_can_get_games_by_season
    game1 = mock
    game2 = mock
    game3 = mock
    @team_stats.stubs(:games_played_in).returns([game1, game2, game3])
    @team_stats.games_played_in.stubs(:map).returns([{"2012" => game1}, {"2012" => game2}, {"2013" => game3}])
    expected = {"2012" => [game1, game2], "2013" => [game3]}
    assert_equal expected, @team_stats.games_by_season(1)
  end

  def test_it_can_get_win_percentage_by_season
    expected = {"2012" => 50.00, "2013" => 100.00}
    game1 = mock
    game2 = mock
    game3 = mock
    @team_stats.stubs(:games_by_season).returns({"2012" => [game1, game2], "2013" => [game3]})
    game1.stubs(:result).returns("WIN")
    game2.stubs(:result).returns("LOSS")
    game3.stubs(:result).returns("WIN")
    assert_equal expected, @team_stats.win_percentage_by_season(1)
  end

  def test_it_can_get_best_season
    result = {"2012" => 50.00, "2013" => 100.00,
                "2014" => 12.31, "2015" => 66.33}
    @team_stats.stubs(:win_percentage_by_season).returns(result)
    assert_equal "2013", @team_stats.best_season(1)
  end
end
