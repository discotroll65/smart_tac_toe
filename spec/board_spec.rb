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

  describe Board, ".default" do
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
end
