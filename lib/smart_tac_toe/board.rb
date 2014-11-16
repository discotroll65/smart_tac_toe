require "spec_helper"

module SmartTacToe
  class Board
    attr_accessor :grid
    def initialize
      @grid = []
      3.times do |row|
        @grid << [Cell.new, Cell.new, Cell.new]
      end
    end
  end
end
