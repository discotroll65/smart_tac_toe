module SmartTacToe
  class Player
    attr_accessor :name, :marker
    def initialize (marker="X")
      @name = "Human"
      @marker = marker
    end


    def possible_wins(board)
      available_winning_combos.each do |possible_win|
        possible_win.each do |move|

        end

      end
    end

  end
end
