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
      result = {answer: false, imm_win_index: nil}
      win_combos = board.win_combos

      win_combos.each_with_index do |combo,index|
        marks = self.count_marks(combo)
        if marks == 2 && !combo_dead?(combo)
          result[:answer] = true 
          result[:imm_win_index] = index
        end
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
