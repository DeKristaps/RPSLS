# frozen_string_literal: true

class Player
  attr_accessor :name, :points, :choice, :oponents_played

  def initialize(name)
    @name = name
    @points = 0
    @choice = ''
    @oponents_played = []
  end
end
