# frozen_string_literal: true

require './player'
require './game_logic'

class Levels
  class << self
    PLAYER_NAMES = [
      'Glass Joe',
      "Dwayne 'The Rock' Johnson",
      'Edward Scissorhands',
      'Clippy',
      'Ben Grimm',
      'Scissorman',
      'Spock',
      'GodZilla',
      'Gorn'
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
      players = define_players(1)
      rounds(3, players)
      winner = GameLogic.evaluate_game(players)
      print_winner(winner)
    end

    def level_two
      players = define_players(3)
      player = players.shift
      oponents = players

      oponents.each do |oponent|
        puts "Your oponent is #{oponent.name}"
        players = [player, oponent]
        rounds(3, players)

        winner = GameLogic.evaluate_game(players)
        print_winner(winner)

        break if winner.first.name != player.name

        oponent.points = 0
        player.points = 0
      end
    end

    def level_three
      puts 'Chose the player count(1 - 9):'
      player_cout = gets.chomp.to_i
      puts 'Pass the number of rounds(1 - 5):'
      round_count = gets.chomp.to_i
      players = define_players(player_cout)

      players.each do |player|
        players.each do |oponent|
          next if oponent.name == player.name
          next if oponent.oponents_played.include?(player.name)

          puts "Your oponent is #{oponent.name}"
          round_players = [player, oponent]
          rounds(round_count, round_players)
          player.oponents_played << oponent.name
          oponent.oponents_played << player.name
        end
      end

      players_sorted = GameLogic.evaluate_game(players)

      puts '###############################################'
      players_sorted.each do |player|
        puts "#{player.name} got :#{player.points} points"
      end
      print_winner(players_sorted)
    end

    private

    def rounds(number_of_rounds, players)
      number_of_rounds.times do
        players.first.choice = players.first.name == 'Player' ? GameLogic.player_choice : GameLogic.ai_choice
        players.last.choice = players.last.name == 'Player' ? GameLogic.player_choice : GameLogic.ai_choice

        GameLogic.evaluate(players)
      end
    end

    def print_winner(players)
      first_place = players.first
      winners = players.select { |player| player.points == first_place.points }

      puts '###############################################'
      puts
      if winners.length > 1
        puts "its a tie between #{winners.map(&:name).join(' and ')}"
      elsif first_place.name == 'Player'
        puts 'You win!'
      else
        puts 'You lose!'
      end
      puts
      puts '###############################################'
    end

    def define_players(count)
      players = [
        Player.new('Player')
      ]
      count.times do |iter|
        players << Player.new(PLAYER_NAMES[iter])
      end
      players
    end
  end
end
