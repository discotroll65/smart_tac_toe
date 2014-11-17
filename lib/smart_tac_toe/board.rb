#require "spec_helper"
module SmartTacToe
  class Board
    attr_accessor :grid
    def initialize (input = Board.default)
      @grid = input
    end

    def get_cell (row, col)
      cell = grid[row][col]
      cell.value
    end

    def fill_cell (row, col, input)
      cell = grid[row][col]
      cell.value = input
    end

    def diagonals
      [  [ grid[0][0],grid[1][1],grid[2][2] ] ,  [  grid[0][2],grid[1][1],grid[2][0]  ]  ]
    end

    def win_combos
      grid + grid.transpose + diagonals
    end

    def combo_win? (cell_combo)
      result = cell_combo.map {|square| square.value}      
      result.uniq.length == 1 && result[0] != ""
    end

    def game_won?
      result = false

      win_combos.each do |combo|
        if combo_win?(combo)
          result = true
          break
        end
      end
      result

    end

    def terminal_display
      grid.each do |row|
        puts " #{row[0].value} | #{row[1].value} | #{row[2].value}"
        puts "===+===+==="
      end
    end

    def game_tied?
      result = true
      result = false if available_moves.size != 0
      result
    end

    def available_moves
      all_moves = (1..9).to_a.map {|move| move.to_s}
      move_array = []

      grid.each do |row|
        row.each do |square|
          union =  ([square.value] & all_moves) 
          if union != []
            move_array << union[0]
          end
        end
      end

      move_array
    end
private
    def self.default
      default_grid = Array.new(3) {Array.new(3) {Cell.new} }
      num = 1

      default_grid.each do |row|
        row.each do |square|
          square.value = num.to_s
          num += 1
        end
      end
    end

  end
end


