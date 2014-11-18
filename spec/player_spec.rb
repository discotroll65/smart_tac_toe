require "spec_helper"

module SmartTacToe
  describe Player, "#marker" do
    it "has a game marker" do
      dude = Player.new("O")
      expect(dude.marker).to eq "O"
    end
  end



end
