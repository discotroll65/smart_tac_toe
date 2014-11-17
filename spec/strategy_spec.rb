require "spec_helper"

module SmartTacToe
  describe Strategy, "#available_winning_combos" do
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

  describe Strategy, "#combo_dead?" do
    it "returns true if two players have put cells in a combo" do
      board = Board.new
      board.fill_cell(0,0,"X")
      board.fill_cell(0,1,"O")

      combos = board.win_combos

      result = board.combo_dead?(combos[0])
      expect(result).to eq true
      
    end
  end
end
