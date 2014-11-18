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

  describe Player, "#count_marks(combo)" do
    it "counts how many of that player's marks are in an available win combo" do
      board = Board.new
      player = Player.new("X")
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"X")
      combo = board.win_combos[0]
      count = player.count_marks(combo)
      expect(count).to eq 2
    end

  end



end
