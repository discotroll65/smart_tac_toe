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

    def about_to_win?(board, search_mode = "both")
      result = {answer: false, imm_win_index: nil}
      win_combos = board.win_combos
      mode = search_mode

      win_combos.each_with_index do |combo,index|
        o_marks = count_marks(combo,"O") if mode == "O" || mode == "both"
        x_marks = count_marks(combo,"X") if mode == "X" || mode == "both"
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

    def one_filled_combo_amount(board, player_marker = self.marker)
      result = 0 
      marker = player_marker
      wincombos = board.win_combos
      wincombos.each do |combo|
        result += 1 if count_marks(combo, marker) == 1
      end
      result
    end

    def open_moves_of_one_filled_combos(board, player_marker = self.marker)
      marker = player_marker
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

    def losing_moves(board)
      marker = self.marker
      marker == "X" ? opponent_marker="O":opponent_marker = "X"
      open_moves = board.available_board_moves
      bad_moves = []

      open_moves.each do |hyp_self_move|
        hyp_open_moves = open_moves - [hyp_self_move]
        first_hyp_board = Marshal.load(Marshal.dump(board))
        first_hyp_board.fill_cell_from_move(hyp_self_move,marker)
#binding.pry
        hyp_open_moves.each do |opponent_retort|
          deep_hyp_board = Marshal.load(Marshal.dump(first_hyp_board))
          deep_hyp_board.fill_cell_from_move(opponent_retort,opponent_marker)

          if about_to_win?(deep_hyp_board, opponent_marker)[:answer]
            opponent_wincell = move_to_win(deep_hyp_board,opponent_marker) 

            inception_board = Marshal.load(Marshal.dump(deep_hyp_board))
            inception_board.fill_cell_from_move(opponent_wincell,marker)
            defender_wincell = move_to_win(inception_board,marker) if about_to_win?(inception_board,marker)[:answer]
          end

          if one_filled_combo_amount(deep_hyp_board,opponent_marker) >= 2
            open_moves_in_combos = open_moves_of_one_filled_combos(deep_hyp_board, opponent_marker)
            overlapping_moves = overlapping_solution_cells(open_moves_in_combos)
          end
         
          overlapping_moves = [] if overlapping_moves == nil
          overlapping_moves.each do |overlap|
            if (overlap != nil && opponent_wincell != nil) && (overlap != opponent_wincell) && (defender_wincell == overlap || defender_wincell == nil)
              bad_moves << hyp_self_move
            end
          end

        end

      end
      bad_moves.uniq!
    end

    def fill_pending_win(board)
      win_pending = about_to_win?(board)
      if win_pending[:answer]
        move_to_make = move_to_win(board)
        board.fill_cell_from_move(move_to_make,self.marker)
      end
    end

    def move_to_win(board, search_mode = "both")
      possible_wins = board.win_combos
      mode = search_mode
      move_to_make = nil
      cell_array = possible_wins[self.about_to_win?(board,mode)[:imm_win_index]]
      combo_of_interest = board.array_of_combo_values(cell_array)
      combo_of_interest.each do |move|
        move_to_make = move if move_valid?(move,board) #move_valid? in Moveable
      end
      move_to_make
    end

  end
end
