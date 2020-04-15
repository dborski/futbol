require_relative 'mathable'

class GameStats
  include Mathable

  attr_reader :games
  def initialize(games)
    @games = games
  end
  
end
