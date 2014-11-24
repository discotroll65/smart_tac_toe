require "spec_helper"

module SmartTacToe
  describe Player, "#marker" do
    it "has a game marker" do
      dude = Player.new("O")
      expect(dude.marker).to eq "O"
    end
  end

  describe Player, "#about_to_win?" do
    board = Board.new
    player = Player.new("X")
    it "returns true if a player has an imminent win" do
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")
      result = player.about_to_win?(board)[:answer]
      expect(result).to eq true
    end
    it "returns false if a player does not have an imminent win" do
      board.fill_cell(0,2,"O")
      result = player.about_to_win?(board)[:answer]
      expect(result).to eq false
     end
  end

  describe Player, "#move_to_win(board)" do
    it "returns the move that will make the player win" do
      board = Board.new
      player = Player.new
      board.fill_cell_from_move("1","X")
      board.fill_cell_from_move("2","X")

      move_to_make = player.move_to_win(board)
      expect(move_to_make).to eq "3"
    end
  end

  describe Player, "#one_filled_combo_amount(board)" do
    it "returns the number of combos having only one cell filled in" do
      player = Player.new
      board_mid = Board.new
      board_corner = Board.new
      board_center = Board.new

      board_mid.fill_cell_from_move("2","X")
      result = player.one_filled_combo_amount(board_mid)
      expect(result).to eq 2

      board_corner.fill_cell_from_move("1","X")
      result = player.one_filled_combo_amount(board_corner)
      expect(result).to eq 3

      board_center.fill_cell_from_move("5","X")
      result = player.one_filled_combo_amount(board_center)
      expect(result).to eq 4

    end
  end

  describe Player, "#losing_moves(board)" do
    it "returns all the moves that would allow the other player to force a win" do
      player = Player.new ("O")
      board_mid = Board.new
      board_corner = Board.new
      board_center = Board.new

      board_center.fill_cell_from_move("5","X")
      result = player.losing_moves(board_center)
      expect(result).to eq ["2","4","6","8"]

      board_mid.fill_cell_from_move("2","X")
      result = player.losing_moves(board_mid)
      expect(result).to eq ["4","6","7","9"]

      board_corner.fill_cell_from_move("1","X")
      result = player.losing_moves(board_corner)
      expect(result).to eq ["2","3","4","6","7","8","9"]


    end
  end

  describe Player, "#count_marks(combo)" do
    it "counts how many of that player's marks are in an available win combo" do
      board = Board.new
      player = Player.new("X")
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")
      combo = board.win_combos[0]
      count = player.count_marks(combo,"X")
      expect(count).to eq 2
    end
  end

  describe Player, "#open_moves_of_one_filled_combos(board)" do
    it "returns an array of arrays, with each inner array containing open moves in a combo that has only one move filled." do

      board = Board.new
      player = Player.new("X")
      board.fill_cell_from_move("1","O")
      board.fill_cell_from_move("5","X")
      board.fill_cell_from_move("3","X")

      result = player.open_moves_of_one_filled_combos(board)
      expect(result).to eq [["2","8"],["4","6"],["6","9"]]
    end 
  end

  describe Player, "#overlapping_solution_cells(open_moves_in_combos)" do
    it "returns an array of available moves located at the intersection of two available win combos that have one cell filled in" do

      board = Board.new
      player = Player.new("X")
      board.fill_cell_from_move("1","O")
      board.fill_cell_from_move("5","X")
      board.fill_cell_from_move("3","X")

      open_moves_in_combos = player.open_moves_of_one_filled_combos(board)
      result = player.overlapping_solution_cells(open_moves_in_combos)
      expect(result).to eq ["6"]
    end 
  end
  
  describe Player, "#fill_pending_win(board)" do
    board = Board.new
    player1 = Player.new("X")
    player2 = Player.new("O")
    it "fills the last square in a combination about to win" do
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")

      possible_wins = board.win_combos
      player1.fill_pending_win(board)
      affected_combo = board.array_of_combo_values(possible_wins[0])
      expect(affected_combo).to eq ["X","X","X"]

      board.fill_cell(0,2,"3")

      possible_wins = board.win_combos
      player2.fill_pending_win(board)
      affected_combo = board.array_of_combo_values(possible_wins[0])
      expect(affected_combo).to eq ["X","X","O"]


    end
  end
end
