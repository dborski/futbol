require './lib/game'
require './lib/game_stats'
require './test/test_helper'
require './lib/collectable'

class GameStatsTest < Minitest::Test
  include Collectable

  def setup
    @games = create_objects("./test/fixtures/games_truncated.csv", Game)
    @game_stats = GameStats.new(@games)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_readable_attributes
    assert_equal @games, @game_stats.games
  end

  def test_from_csv_creates_array_of_all_games
    assert_instance_of GameStats, @game_stats
  end

  def test_it_can_return_all_scores
    all_scores_array = [5, 5, 3, 5, 4, 3, 5, 3, 1, 3, 3, 4, 2, 3, 3, 5, 5, 6, 4, 3, 5, 5, 6, 4, 3, 6, 4, 1, 6, 3]
    assert_equal all_scores_array, @game_stats.all_scores
  end

  def test_it_can_return_highest_total_score
    assert_equal 6, @game_stats.highest_total_score
  end

  def test_it_can_return_lowest_total_score
    assert_equal 1, @game_stats.lowest_total_score
  end

  def test_it_can_return_percentage_home_wins
    assert_equal 0.50, @game_stats.percentage_home_wins
  end

  def test_it_can_return_percentage_visitor_wins
    assert_equal 0.30, @game_stats.percentage_visitor_wins
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.20, @game_stats.percentage_ties
  end

  def test_it_can_return_count_of_games_by_season
    expected_hash = {
                  "20122013" => 21,
                  "20132014" => 9
                  }
    assert_equal expected_hash, @game_stats.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 3.93, @game_stats.average_goals_per_game
  end

  def test_it_can_return_average_goal_by_season
    expected_hash = {
                  "20122013" => 4.0,
                  "20132014" => 3.78
                  }
    assert_equal expected_hash, @game_stats.average_goals_by_season
  end
end
