require "spec_helper"

module SmartTacToe
  describe Board, "#grid" do
    it "by default is a grid of 3 rows and 3 columns" do
      default_board = Board.new
      game_array = default_board.grid
      row_size = game_array.size
      column_size = game_array.transpose.size

      expect(row_size).to eq 3
      expect(column_size).to eq 3

    end
    it "is made up of Cells" do
      game_array = Board.new.grid
      game_array.each do |row|
        row.each do |square|
          expect(square.class).to eq SmartTacToe::Cell
        end 
      end
    end

  end

  describe Board, "#get_cell" do
    it "returns value of a cell corresponding to a board coordinate" do
      board = Board.new
      board.grid[0][0].value = "X"

      got_value = board.get_cell(0,0)

      expect(got_value).to eq "X"
    end 
  end

  describe Board, "#fill_cell" do
    it "fills a cell with a given value" do
      board = Board.new
      board.fill_cell(0,0,"X")

      expect(board.get_cell(0,0)).to eq "X"
    end
  end

  describe Board, "Board.default" do
    it "creates an array that would correspond to a fresh tictactoe grid" do
      values_array = []
      grid = Board.default

      grid.each do |row|
        row.each do |square|
          values_array << square.value
        end
      end

      expect(values_array).to eq (1..9).map { |element| element.to_s}
    end
  end

  describe Board, "#diagonals" do
    it "creates arrays of the diagonals of the board grid" do
      board = Board.new
      diags = board.diagonals

      board.fill_cell(0,0,"X")
      board.fill_cell(1,1,"X")
      board.fill_cell(2,2,"X")

      value_array_x = diags[0].map {|square| square.value}
      expect(value_array_x).to eq ["X","X","X"]
     
      board.fill_cell(0,2,"O")
      board.fill_cell(1,1,"O")
      board.fill_cell(2,0,"O")
      
      value_array_o = diags[1].map {|square| square.value}
      expect(value_array_o).to eq ["O","O","O"]
     
    end
  end

  describe Board, "#wincombos" do
    it "creates an array of all possible win combos" do
      board = Board.new
      expect(board.win_combos.size).to eq 8
    end
  end

  describe Board, "#win?" do
    it "Returns true for a wincombo all filled in" do
      board = Board.new
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")
      board.fill_cell(0,2,"X")
      top_horizontal = board.win_combos[0]

      result = board.win?(top_horizontal)
      expect(result).to eq true      
    end

    it "Returns false for a wincombo not all filled in" do
      board = Board.new
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")
      board.fill_cell(0,2,"O")
      top_horizontal = board.win_combos[0]

      result = board.win?(top_horizontal)
      expect(result).to eq false      
    end
 
  end
end
