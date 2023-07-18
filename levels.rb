# frozen_string_literal: true

require './player'
require './game_logic'

class Levels
  class << self
    PLAYER_NAMES = [
      "Glass Joe",
      "Dwayne 'The Rock' Johnson",
      "Edward Scissorhands",
      "Clippy",
      "Ben Grimm",
      "Scissorman",
      "Spock",
      "GodZilla",
      "Gorn",
    ].freeze

    VALID_CHOICES = %w[
      1
      2
      3
      exit
    ].freeze

    def chose_level
      3.times do |i|
        iter = i + 1
        puts "Type #{iter} for level #{iter}"
      end
      puts 'Type exit to quit the game'

      choice = gets.chomp.downcase

      until VALID_CHOICES.include?(choice)
        puts "#{choice} is not a valid option. chose again"
        choice = gets.chomp.downcase
      end

      choice
    end

    def level_one
      player = Player.new('Player')
      oponent = Player.new('')

      3.times do
        player.choice = GameLogic.player_choice
        oponent.choice = GameLogic.ai_choice

        GameLogic.evaluate([player, oponent])
      end

      winer = GameLogic.evaluate_game([player, oponent])

      puts '###############################################'
      puts
      puts "               #{winer} wins!                  "
      puts
      puts '###############################################'
    end

    def level_two
      player = Player.new('Player')
      oponent1 = Player.new('Dwayne The Rock Johnson')
      oponent2 = Player.new('Edward Scissorhands')
      oponent3 = Player.new('Clippy')
      winer = ''

      oponents = [oponent1, oponent2, oponent3]

      oponents.each do |oponent|
        winer = ''
        puts "Your oponent is #{oponent.name}"
        3.times do
          player.choice = GameLogic.player_choice
          oponent.choice = GameLogic.ai_choice

          GameLogic.evaluate([player, oponent])
        end

        winer = GameLogic.evaluate_game([player, oponent])

        puts '###############################################'
        puts '|                                             |'
        if winer == player.name
          puts '|              You won this round             |'
        else
          puts '|             You lost!                       |'
        end
        puts '|                                             |'
        puts '###############################################'

        break if winer != player.name

        player.points = 0
      end
    end

    def level_three
      puts "Chose the player count(1 - 9):"
      player_cout = gets.chomp.to_i
      puts "Pass the number of rounds(1 - 5):"
      round_count = gets.chomp.to_i
      players = [Player.new("Player")]

      player_cout.times do |iter|
        players << Player.new(PLAYER_NAMES[iter])
      end

      players.each do | player|
        players.each do | oponent |
          next if oponent.name == player.name
          next if oponent.oponents_played.include?(player.name)
          puts "Your oponent is #{oponent.name}"
          round_count.times do
            player.choice = player.name == "Player" ? GameLogic.player_choice : GameLogic.ai_choice
            oponent.choice = oponent.name == "Player" ? GameLogic.player_choice : GameLogic.ai_choice

            GameLogic.evaluate([player, oponent])
          end
          player.oponents_played << oponent.name
          oponent.oponents_played << player.name
        end
      end
      puts "###############################################"
      players.each do | player |
        puts "#{player.name} got :#{player.points} points"
      end
      puts "###############################################"
    end
  end
end
