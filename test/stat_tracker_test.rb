require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/league_stats'
require './lib/season_stats'
require './lib/team_stats'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    teams_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: teams_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_readable_attributes
    assert_instance_of Game, @stat_tracker.games[0]
    assert_instance_of Team, @stat_tracker.teams[0]
    assert_instance_of GameTeam, @stat_tracker.game_teams[0]
    assert_instance_of LeagueStats, @stat_tracker.league_stats
  end

  def test_from_csv_creates_array_of_all_games
    assert_instance_of Array, @stat_tracker.games
    assert_equal 7441, @stat_tracker.games.length
    assert_instance_of Game, @stat_tracker.games[0]
    assert_instance_of Game, @stat_tracker.games[-1]
  end

  def test_returns_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_return_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_return_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_it_can_return_percentage_home_wins
    assert_equal 40.0, @stat_tracker.percentage_home_wins
  end

  def test_it_can_return_percentage_visitor_wins
    assert_equal 40.0, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_return_percentage_ties
    assert_equal 20.0, @stat_tracker.percentage_ties
  end

  def test_it_can_return_percentage_ties
    assert_equal 20.0, @stat_tracker.percentage_ties
  end

  def test_it_can_return_count_of_games_by_season
    expected_hash = {
                  "20122013" => 806,
                  "20162017" => 1317,
                  "20142015" => 1319,
                  "20152016" => 1321,
                  "20132014" => 1323,
                  "20172018" => 1355
                  }
    assert_equal expected_hash, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_it_can_return_average_goals_by_season
    expected_hash = {
                  "20122013" => 4.12,
                  "20162017" => 4.23,
                  "20142015" => 4.14,
                  "20152016" => 4.16,
                  "20132014" => 4.19,
                  "20172018" => 4.44
                  }
    assert_equal expected_hash, @stat_tracker.average_goals_by_season
  end

  def test_it_can_get_team_info
    expected = {team_id: 1, franchise_id: 23,
                team_name: "Atlanta United", abbreviation: "ATL",
                link: "/api/v1/teams/1"
                }
    assert_equal expected, @stat_tracker.team_info(1)
  end

end
