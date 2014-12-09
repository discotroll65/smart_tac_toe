module SmartTacToe
  module Strategic

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
