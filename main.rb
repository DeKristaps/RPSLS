# frozen_string_literal: true

require './levels'

puts 'This the the game ROCK, PAPER, SCISSORS, LIZARD, SPOCK.'
puts 'Chsoe a game mode:'
choice = Levels.chose_level

while choice != 'exit'
  case choice
  when '1'
    Levels.level_one
  when '2'
    Levels.level_two
  when '3'
    Levels.level_three
  end
  choice = Levels.chose_level
end
