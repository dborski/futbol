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
    assert_instance_of TeamStats, @stat_tracker.team_stats
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

  def test_it_can_get_best_season
    assert_equal "20132014", @stat_tracker.best_season(6)
  end

  def test_it_can_get_worst_season
    assert_equal "20142015", @stat_tracker.worst_season(6)
  end

  def test_it_can_get_average_win_percentage
    assert_equal 49.22, @stat_tracker.average_win_percentage(6)
  end

  def test_it_can_get_most_goals
    assert_equal 7, @stat_tracker.most_goals_scored(18)
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored(18)
  end

  def test_it_can_get_favorite_opponent
    assert_equal "DC United", @stat_tracker.favorite_opponent(18)
  end

  def test_it_can_get_rival
    assert_equal "LA Galaxy", @stat_tracker.rival(18)
  end

  def test_it_can_get_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_it_can_get_worst_coach
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert_equal "Ted Nolan", @stat_tracker.worst_coach("20142015")
  end

  def test_it_can_get_most_accurate_team
    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  def test_it_can_get_least_accurate_team
    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  def test_it_can_get_team_with_most_tackles
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  def test_it_can_get_team_with_fewest_tackles
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

  def test_it_can_return_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_it_can_return_worst_offense
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end
end
