require "spec_helper"

module SmartTacToe
  describe Game do
    it "has two players" do
      match = Game.new
      players = match.players
      expect(players.size).to eq 2
    end
  end

  describe Game, "#convert_move_to_coords" do
    it "Takes a number 1 - 9, and converts it to board coordinates" do
      
      game = Game.new

      move_inputs = 1..9
      move_inputs = move_inputs.to_a.map {|move| move.to_s}
      move_outputs = move_inputs.map {|move| game.convert_move_to_coords(move)}


      expect(move_outputs[0]).to eq [0,0]
      expect(move_outputs[1]).to eq [0,1]
      expect(move_outputs[2]).to eq [0,2]
      expect(move_outputs[3]).to eq [1,0]
      expect(move_outputs[4]).to eq [1,1]
      expect(move_outputs[5]).to eq [1,2]
      expect(move_outputs[6]).to eq [2,0]
      expect(move_outputs[7]).to eq [2,1]
      expect(move_outputs[8]).to eq [2,2]

    end
  end
end