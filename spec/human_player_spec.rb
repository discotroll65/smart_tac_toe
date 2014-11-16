require "spec_helper"

module SmartTacToe
  describe HumanPlayer, "#marker" do
    it "has a game marker" do
      dude = HumanPlayer.new("O")
      expect(dude.marker).to eq "O"
    end
  end
end
