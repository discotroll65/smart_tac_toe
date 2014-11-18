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

  describe Board, "#combo_win?" do
    it "Returns true for a wincombo all filled in" do
      board = Board.new
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")
      board.fill_cell(0,2,"X")
      top_horizontal = board.win_combos[0]

      result = board.combo_win?(top_horizontal)
      expect(result).to eq true      
    end

    it "Returns false for a wincombo not all filled in" do
      board = Board.new
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")
      board.fill_cell(0,2,"O")
      top_horizontal = board.win_combos[0]

      result = board.combo_win?(top_horizontal)
      expect(result).to eq false      
    end
 
  end

  describe Board, "#game_won?" do
    it "returns true if a player has filled up a winning combo" do
      board = Board.new
      board.fill_cell(2,0,"X")
      board.fill_cell(2,1,"X")
      board.fill_cell(2,2,"X")

      expect(board.game_won?).to eq true
    end

    it "returns false if a player has filled up a winning combo" do
      board = Board.new
      board.fill_cell(2,0,"O")
      board.fill_cell(2,1,"X")
      board.fill_cell(2,2,"X")

      expect(board.game_won?).to eq false
    end

  end

  describe Board, "#game_tied?" do
    it "returns true if all squares are taken up" do
      board = Board.new
      marker = -1

      board.grid.each do |row|
        row.each do |square|
          if marker > 0
            square.value = "X"
          else
            square.value = "O"
          end
          marker *= -1
        end
      end

      expect(board.game_tied?).to eq true
    end
  end

  describe Board, "#available_moves" do
    it "returns an array of available moves" do
      board = Board.new
      all_moves = (1..9).to_a.map {|move| move.to_s}
      
      expect(board.available_moves).to eq all_moves

      board.fill_cell(0,0,"X")
      expect(board.available_moves).to eq all_moves - ["1"]

      board.fill_cell(0,1,"O")
      expect(board.available_moves).to eq all_moves - ((1..2).to_a.map {|move| move.to_s})

      board.fill_cell(0,2,"X")
      expect(board.available_moves).to eq all_moves - ((1..3).to_a.map {|move| move.to_s})
      
      board.fill_cell(1,0,"O")
      expect(board.available_moves).to eq all_moves - ((1..4).to_a.map {|move| move.to_s})

      board.fill_cell(1,1,"X")
      expect(board.available_moves).to eq all_moves - ((1..5).to_a.map {|move| move.to_s})

      board.fill_cell(1,2,"O")
      expect(board.available_moves).to eq all_moves - ((1..6).to_a.map {|move| move.to_s})

      board.fill_cell(2,0,"X")
      expect(board.available_moves).to eq all_moves - ((1..7).to_a.map {|move| move.to_s})

      board.fill_cell(2,1,"O")
      expect(board.available_moves).to eq all_moves - ((1..8).to_a.map {|move| move.to_s})

      board.fill_cell(2,2,"X")
      expect(board.available_moves).to eq []


    end
  end

  describe Board, "#available_winning_combos" do
    it "returns wincombos that don't have two players in them" do
      board = Board.new
      board.fill_cell(0,1,"X")
      board.fill_cell(0,0,"O")
      board.fill_cell(0,2,"X")
      board.fill_cell(1,0,"X")
      board.fill_cell(2,0,"O")
      
      available_wins =  [["3","6","9"],["1","5","9"],["4","5","6"],["7","8","9"], ["2","5","8"]].sort!
      result = board.available_winning_combos
      expect(result.size).to eq 5
      expect(result.sort!).to eq available_wins
    end
  end

end
