#require_relative "./spec_helper.rb"
require_relative "spec_helper"


module SmartTacToe
  describe Cell, "#initialize" do
    it "is an empty string if initialized with no argument" do
      empty_square = Cell.new
      square_value = empty_square.value
      expect(square_value).to eq ""
    end

    it "has the value of the passed in argument if initialized with an argument" do
      move = "X"
      filled_square = Cell.new(move)
      square_value = filled_square.value

      expect(square_value).to eq move
    end 
  end
end
