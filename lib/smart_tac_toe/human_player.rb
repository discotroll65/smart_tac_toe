module SmartTacToe
  class HumanPlayer
    attr_accessor :name, :marker
    def initialize (marker="X")
      @name = "Human"
      @marker = marker
    end

  end
end
