require "spec_helper"

module SmartTacToe


  describe Strategic, "#combo_dead?" do
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
