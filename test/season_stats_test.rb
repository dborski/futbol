require './lib/team'
require './lib/game'
require './lib/game_team'
require './lib/season_stats'
require './test/test_helper'

class SeasonStatsTest < Minitest::Test

  def setup
    @game_teams = GameTeam.from_csv("./test/fixtures/game_teams_truncated_new.csv")
    @games = Game.from_csv("./test/fixtures/game_truncated_new.csv")
    @teams = Team.from_csv("./data/teams.csv")
    @season_stats = SeasonStats.new(@game_teams, @games, @teams)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_it_has_readable_attributes
    assert_equal @game_teams, @season_stats.game_teams
    assert_equal @games, @season_stats.games
    assert_equal @teams, @season_stats.teams
  end

  def test_all_games_by_season
    assert_equal 30, @season_stats.games_ids_by_season("20122013").length
    assert_equal 30, @season_stats.games_ids_by_season("20132014").length
    assert_equal 30, @season_stats.games_ids_by_season("20142015").length
    assert_equal 30, @season_stats.games_ids_by_season("20152016").length
    assert_equal 30, @season_stats.games_ids_by_season("20162017").length
    assert_equal 30, @season_stats.games_ids_by_season("20172018").length
  end

  def test_games_by_season_id
    assert_equal 60, @season_stats.games_by_season_id("20122013").length
    assert_equal 60, @season_stats.games_by_season_id("20132014").length
    assert_equal 60, @season_stats.games_by_season_id("20142015").length
    assert_equal 60, @season_stats.games_by_season_id("20152016").length
    assert_equal 60, @season_stats.games_by_season_id("20162017").length
    assert_equal 60, @season_stats.games_by_season_id("20172018").length
  end

  def test_winningnest_coach
    assert_equal "Todd McLellan", @season_stats.winningest_coach("20122013")
    assert_equal "Todd Richards", @season_stats.winningest_coach("20132014")
    assert_equal "Todd Richards", @season_stats.winningest_coach("20142015")
    assert_equal "Willie Desjardins", @season_stats.winningest_coach("20152016")
    assert_equal "Todd McLellan", @season_stats.winningest_coach("20162017")
  end
end

# Season Statistics
# These methods each take a season id as an argument and return the values described below.
#
# Method	Description	Return Value
# winningest_coach	Name of the Coach with the best win percentage for the season	String

# worst_coach	Name of the Coach with the worst win percentage for the season	String

# most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String

# least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String

# most_tackles	Name of the Team with the most tackles in the season	String

# fewest_tackles	Name of the Team with the fewest tackles in the season	String
