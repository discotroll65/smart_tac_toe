require_relative "./spec_helper.rb"

module SmartTacToe
  describe Cell, "#instantiate" do
    it "is an empty string if instantiated with no argument" do
      square = Cell.new
      expect(square).to eq ""
    end
  end
end
