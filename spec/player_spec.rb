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
