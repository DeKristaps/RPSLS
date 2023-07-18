# frozen_string_literal: true

class GameLogic
  class << self
    RULES = {
      rock: %w[scissors lizard],
      paper: %w[rock spock],
      scissors: %w[lizard paper],
      lizard: %w[paper spock],
      spock: %w[rock scissors]
    }.freeze

    CHOICE = %w[
      rock
      paper
      scissors
      lizard
      spock
    ].freeze

    def evaluate(choice)
      puts '###############################################'
      puts
      puts "#{choice.first.name} picked: #{choice.first.choice}"
      puts "#{choice.last.name} picked: #{choice.last.choice}"
      puts
      if RULES[choice.first.choice.to_sym].include?(choice.last.choice)
        puts "#{choice.first.name} wins with #{choice.first.choice} beating #{choice.last.choice}."
        choice.first.points += 1
      elsif RULES[choice.last.choice.to_sym].include?(choice.first.choice)
        puts "#{choice.last.name} wins with #{choice.last.choice} beating #{choice.first.choice}."
        choice.last.points += 1
      else
        puts 'Its a tie'
      end
      puts
      puts '###############################################'
    end

    def evaluate_game(players)
      players.min { |a, b| b.points <=> a.points }.name
    end

    def player_choice
      puts "Chose one: #{CHOICE.join(', ')}:"

      choice = gets.chomp.downcase until CHOICE.include?(choice)
      choice
    end

    def ai_choice
      CHOICE.sample
    end
  end
end
