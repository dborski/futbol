require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/team_stats'
require './test/test_helper'
require './lib/collectable'

class TeamStatsTest < Minitest::Test
  include Collectable

  def setup
    @game_teams = create_objects("./test/fixtures/game_teams_truncated_new.csv", GameTeam)
    @teams = create_objects("./data/teams.csv", Team)
    @games = create_objects("./test/fixtures/game_truncated_new.csv", Game)
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
    expected = {"team_id" => "1", "franchise_id" => "23",
                "team_name" => "Atlanta United", "abbreviation" => "ATL",
                "link" => "/api/v1/teams/1"
                }
    assert_equal expected, @team_stats.team_info("1")
  end

  def test_it_can_get_season_and_game_from_game_id
    game3 = mock
    game_team3 = mock
    @game_teams.stubs(:find).returns(game_team3)
    @games.stubs(:find).returns(game3)
    game3.stubs(:season).returns("20122013")
    expected = {"20122013" => game_team3}
    assert_equal expected, @team_stats.season_from_game(2012020004, "1")
  end

  def test_it_can_get_games_played_in
    assert_equal 24, @team_stats.games_played_in("6").length
    assert_equal 24, @team_stats.games_played_in("17").length

    @team_stats.games_played_in("6").each do |game|
      assert_instance_of GameTeam, game
    end

    @team_stats.games_played_in("6").each do |game|
      assert_equal "6", game.team_id
    end
  end

  def test_it_can_get_average_win_percentage
    assert_equal 0.33, @team_stats.average_win_percentage("17")
    assert_equal 0.38, @team_stats.average_win_percentage("6")
  end

  def test_it_can_get_most_goals_scored
    assert_equal 3, @team_stats.most_goals_scored("17")
    assert_equal 4, @team_stats.most_goals_scored("5")
  end
  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored("17")
    assert_equal 0, @team_stats.fewest_goals_scored("6")
    assert_equal 0, @team_stats.fewest_goals_scored("5")
  end

  def test_it_can_get_games_by_season
    game1 = mock
    game2 = mock
    game3 = mock
    @team_stats.stubs(:games_played_in).returns([game1, game2, game3])
    @team_stats.games_played_in.stubs(:map).returns([{"2012" => game1}, {"2012" => game2}, {"2013" => game3}])
    expected = {"2012" => [game1, game2], "2013" => [game3]}
    assert_equal expected, @team_stats.games_by_season("1")
  end

  def test_it_can_get_win_percentage_by_season
    expected = {"2012" => 0.5, "2013" => 1.0}
    game1 = mock
    game2 = mock
    game3 = mock
    @team_stats.stubs(:games_by_season).returns({"2012" => [game1, game2], "2013" => [game3]})
    game1.stubs(:result).returns("WIN")
    game2.stubs(:result).returns("LOSS")
    game3.stubs(:result).returns("WIN")
    assert_equal expected, @team_stats.win_percentage_by_season("1")
  end

  def test_it_can_get_best_season
    result = {"2012" => 50.00, "2013" => 100.00,
                "2014" => 12.31, "2015" => 66.33}
    @team_stats.stubs(:win_percentage_by_season).returns(result)
    assert_equal "2013", @team_stats.best_season("1")
  end

  def test_it_can_get_worst_season
    result = {"2012" => 50.00, "2013" => 100.00,
                "2014" => 12.31, "2015" => 66.33}
    @team_stats.stubs(:win_percentage_by_season).returns(result)
    assert_equal "2014", @team_stats.worst_season("1")
  end

  def test_it_can_find_opponent_games
    assert_equal "5", @team_stats.find_opponent_games(2012020001,"4").team_id
    assert_instance_of GameTeam, @team_stats.find_opponent_games(2012020001,"4")
    assert_equal "52", @team_stats.find_opponent_games(2012020002,"9").team_id
  end

  def test_it_can_get_all_games_by_opponent
    game_team1 = mock
    game_team2 = mock
    game_team3 = mock
    game_team4 = mock
    game_team5 = mock
    game_team6 = mock
    @team_stats.stubs(:games_played_in).returns([game_team1, game_team3, game_team5])
    @team_stats.stubs(:game_teams).returns([game_team1, game_team2, game_team3, game_team4, game_team5, game_team6])
    game_team1.stubs(:game_id).returns("1")
    game_team2.stubs(:game_id).returns("1")
    game_team3.stubs(:game_id).returns("2")
    game_team4.stubs(:game_id).returns("2")
    game_team5.stubs(:game_id).returns("3")
    game_team6.stubs(:game_id).returns("3")

    game_team1.stubs(:team_id).returns("1")
    game_team2.stubs(:team_id).returns("2")
    game_team3.stubs(:team_id).returns("1")
    game_team4.stubs(:team_id).returns("3")
    game_team5.stubs(:team_id).returns("1")
    game_team6.stubs(:team_id).returns("3")
    expected = {"2" => [game_team2], "3" => [game_team4, game_team6]}
    assert_equal expected, @team_stats.games_by_opponent("1")
  end

  def test_it_can_gets_opponent_win_percentage
    game_team1 = mock
    game_team2 = mock
    game_team3 = mock
    game_team4 = mock
    game_team5 = mock
    game_team6 = mock
    game_team7 = mock
    game_team8 = mock

    @team_stats.stubs(:games_by_opponent).returns({ "2" => [game_team1, game_team2, game_team3],
                                                    "3" => [game_team4, game_team5],
                                                    "5" => [game_team6, game_team7, game_team8]})

    game_team1.stubs(:result).returns("WIN")
    game_team2.stubs(:result).returns("LOSS")
    game_team3.stubs(:result).returns("LOSS")
    game_team4.stubs(:result).returns("WIN")
    game_team5.stubs(:result).returns("LOSS")
    game_team6.stubs(:result).returns("WIN")
    game_team7.stubs(:result).returns("WIN")
    game_team8.stubs(:result).returns("LOSS")

    expected = {"2" => 0.33,
                "3" => 0.50,
                "5" => 0.67}
    assert_equal expected, @team_stats.opponent_win_percentages("1")
  end

  def test_it_can_get_rival_and_favorite_opponent
    @team_stats.stubs(:opponent_win_percentages).returns({"2" => 33.33,
                                                          "3" => 50.00,
                                                          "5" => 66.67})

    assert_equal "Sporting Kansas City", @team_stats.rival("1")
    assert_equal "Seattle Sounders FC", @team_stats.favorite_opponent("1")
  end

  def test_it_can_find_team_name_by_team_id
    assert_equal "Chicago Fire", @team_stats.find_name("4")
  end
end
