module SmartTacToe
  module Strategic



    def combo_mapper(combo_indices)
      combo_map_hash = {
        0 => ["1","2","3"],
        1 => ["4","5","6"],
        2 => ["7","8","9"],
        3 => ["1","4","7"],
        4 => ["2","5","8"],
        5 => ["3","6","9"],
        6 => ["1","5","9"],
        7 => ["3","5","7"]
      }
      available_combos = []
      combo_indices.each do |combo_index|
        available_combos << combo_map_hash[combo_index]
      end
      available_combos
    end

    def combo_dead?(combo)
      result = false
      bomb = ""

      combo.each do |cell|
        value = cell.value

        if bomb == ""
          bomb = "O" if value == "X"
          bomb = "X" if value == "O"
        else
          result = true if value == bomb
        end 
      end

      result
    end
  end
end
