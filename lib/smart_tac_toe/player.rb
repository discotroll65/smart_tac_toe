require_relative "./strategic.rb"
require_relative "./movable.rb"

module SmartTacToe
  class Player
    include Strategic
    include Movable
    attr_accessor :name, :marker

    def initialize (marker="X")
      @name = "Human"
      @marker = marker
    end

    def about_to_win?(board)
      result = {answer: false, imm_win_index: nil}
      win_combos = board.win_combos

      win_combos.each_with_index do |combo,index|
        o_marks = count_marks(combo,"O")
        x_marks = count_marks(combo,"X")
        if o_marks == 2 || x_marks == 2 && !combo_dead?(combo)
          result[:answer] = true 
          result[:imm_win_index] = index
        end
      end

      result
    end

    def count_marks(combo,mark) #combo is an array of cells
      count = 0
      combo.each do |cell|
        count += 1 if cell.value == mark
      end
      count
    end

    def one_filled_combo_amount(board)
      result = 0 
      marker = self.marker
      wincombos = board.win_combos
      wincombos.each do |combo|
        result += 1 if count_marks(combo, marker) == 1
      end
      result
    end

    def open_moves_of_one_filled_combos(board)
      marker = self.marker
      open_move_array = []
      checkable_combos = board.win_combos

      checkable_combos.each do |combo|
        if count_marks(combo, marker) == 1 && !combo_dead?(combo)
          open_move_array << available_combo_moves(combo)
        end
      end

      open_move_array.sort!
    end

    def overlapping_solution_cells(open_moves_in_combos)
      overlapping_cells = []
      open_moves_in_combos.each do |solution|
        open_moves_in_combos.each do |other_solution|
          overlap = (solution & other_solution)[0]
          if (solution != other_solution) && (overlap != nil)
            overlapping_cells << overlap
          end
        end
      end
      overlapping_cells.uniq!
    end

    def fill_pending_win(board)
      win_pending = about_to_win?(board)
      if win_pending[:answer]
        move_to_make = move_to_win(board)
        board.fill_cell_from_move(move_to_make,self.marker)
      end
    end

    def move_to_win(board)
      possible_wins = board.win_combos
      move_to_make = nil
      cell_array = possible_wins[self.about_to_win?(board)[:imm_win_index]]
      combo_of_interest = board.array_of_combo_values(cell_array)
      combo_of_interest.each do |move|
        move_to_make = move if move_valid?(move,board) #move_valid? in Moveable
      end
      move_to_make
    end

  end
end
