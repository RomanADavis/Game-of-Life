# lib/game_of_life.rb


class Game
  attr_accessor :world, :seeds
  
  def initialize world=World.new, seeds=[]
    @world = world
    @seeds = seeds
    
    seeds.each {|seed| world.cell_grid[seed[0]][seed[1]].alive = true}
  end
end

class World
  attr_accessor :rows, :cols, :cell_grid
  def initialize rows=3, cols=3
    @rows = rows
    @cols = cols
    @cell_grid= Array.new(rows) {|row| Array.new(cols) {|col| Cell.new(col, row)}}
  end
end

class Cell
  attr_accessor :alive, :x, :y
  def initialize x=0, y=0
    @alive = false
    @x = x
    @y = y
  end
  
  def alive?
    @alive
  end
end