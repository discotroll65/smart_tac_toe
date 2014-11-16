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
    it "is made up of empty Cells" do
      game_array = Board.new.grid
      game_array.each do |row|
        row.each do |square|
          expect(square.value).to eq ""
          expect(square.class).to eq SmartTacToe::Cell
        end 
      end
    end


  end

  describe Board, "#move" do
    it "takes a move and updates a board" do
    end
  end
  
end
