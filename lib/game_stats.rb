require_relative 'mathable'

class GameStats
  include Mathable

  attr_reader :games
  def initialize(games)
    @games = games
  end

  def all_scores
    @games.map { |game| game.away_goals + game.home_goals }
  end

  def highest_total_score
    all_scores.max
  end

  def lowest_total_score
    all_scores.min
  end

  def percentage_home_wins
    home_wins = @games.find_all { |game| game.home_goals > game.away_goals}.count
    percent(home_wins, @games)
  end

  def percentage_visitor_wins
    visitor_wins = @games.find_all { |game| game.home_goals < game.away_goals}.count
    percent(visitor_wins, @games)
  end

  def percentage_ties
    ties = @games.find_all { |game| game.home_goals == game.away_goals}.count
    percent(ties, @games)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by { |game| game.season }
    games_by_season.transform_values { |games| games.length }
  end

  def average_goals_per_game
    average(all_scores.sum, @games.length)
  end

  def average_goals_by_season
    games_by_season = @games.group_by { |game| game.season }
    games_by_season.transform_values do |game|
      game_scores = game.map { |game| game.away_goals + game.home_goals }
      average(game_scores.sum, game_scores.length)
    end
  end
end
