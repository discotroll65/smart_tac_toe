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
