require 'pry'
require 'pry-byebug'
require_relative "../lib/smart_tac_toe.rb"

def enter_terminal(move, game)
  board = game.board
  current_marker = game.current_marker
  
  move = handle_terminal(move, game)
  board.fill_cell_from_move(move,current_marker)
end

def handle_terminal(move, game)
  board = game.board
  current_marker = game.current_marker

  while !game.move_valid?(move)
    board.terminal_display
    puts "Sorry, not a valid move!"
    puts "#{current_marker}, please enter your move again, 1-9"
    print ">>"
    move = gets.strip
  end
  move
end

game = SmartTacToe::Game.new
board = game.board
current_marker = game.current_marker

#Greeting
puts "Welcome to Tic Tac Toe!"
puts "Choose your opponent:"
puts "Human: 1"
puts "HAL 2014: 2"
print ">>"

choice = gets.strip

#See who goes first
if choice == "2"
  puts "Do you want to go first or second?"
  puts "First: 1"
  puts "Second: 2"
  print ">>"

  starter_choice = gets.strip
end

if starter_choice == "2"
  player_flag = -1
else
  player_flag = 1
end

puts "\n\n"
if player_flag == -1 && choice == "2"
  puts "Okay, HAL 2014 will go first"
end

#Play game until someone wins
while true
  if player_flag == 1 || choice == "1"
    board.terminal_display
    puts
    puts "#{current_marker}'s turn. Enter your move:"
    print ">>"

    move = gets.strip
    enter_terminal(move, game)
    puts

  else
    game.hal_turn
    puts "HAL 2014 has made its move"
  end

  break if board.game_won? || board.game_tied?
  player_flag *= -1
  game.switch_turn
  current_marker = game.current_marker
end

board.terminal_display
puts "Game Over!"
puts "#{current_marker} wins!" if board.game_won?
puts "Cat's Game!" if board.game_tied?
puts "~~~~~~~~~~~~~~~~~~~~"

puts"\n\n\n\n"

