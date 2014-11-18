require_relative "./strategic.rb"

module SmartTacToe
  class Player
    include Strategic
    attr_accessor :name, :marker

    def initialize (marker="X")
      @name = "Human"
      @marker = marker
    end

    def about_to_win?(board)
      result = false
      win_combos = board.win_combos

      win_combos.each do |combo|
        marks = self.count_marks(combo)
        result = true if marks == 2 && !combo_dead?(combo)
      end

      result
    end

    def count_marks(combo)
      count = 0
      marked = self.marker

      combo.each do |cell|
        count += 1 if cell.value == marked
      end
      count
    end

  end
end
