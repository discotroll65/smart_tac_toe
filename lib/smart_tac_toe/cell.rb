require_relative "../smart_tac_toe.rb"

module SmartTacToe
  class Cell
    attr_accessor :value
    def initialize (value= "")
      @value = value
    end
  end
end

