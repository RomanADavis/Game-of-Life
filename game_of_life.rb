# lib/game_of_life.rb


class Game
  attr_accessor :world, :seeds
  
  def initialize world=World.new, seeds=[]
    @world = world
    @seeds = seeds
    
    seeds.each {|seed| world.cell_grid[seed[0]][seed[1]].alive = true}
  end
  
  def tick!
    dying_cells = []
    thriving_cells = []
    @world.cells.each do |cell|
      # Rule 1
      dying_cells << cell if cell.alive? && world.neighbors(cell).length < 2
      # Rule 2 maintains status quo. Should need no code.
      # Rule 3
      dying_cells << cell if cell.alive? && world.neighbors(cell).length > 3
      # Rule 4
      thriving_cells << cell if world.neighbors(cell).length == 3 unless cell.alive? 
    end
    dying_cells.each {|cell| cell.die!}
    thriving_cells.each {|cell| cell.reproduce!}
  end
end

class World
  attr_accessor :rows, :cols, :cell_grid, :cells
  def initialize rows=3, cols=3
    @rows = rows
    @cols = cols
    @cells = []
    @cell_grid = Array.new(rows) do |row|
                  Array.new(cols) do |col|
                    cell = Cell.new(col, row)
                    cells << cell
                    cell
                  end
                end
  end
  
  def neighbors cell
    live_neighbors = []
    candidates = []
    # detects neighbors to the north
    candidates << self.cell_grid[cell.y - 1][cell.x] if cell.y > 0
    # detects neighbors to the northeast
    candidates << self.cell_grid[cell.y - 1][cell.x + 1] if cell.y > 0 && cell.x < (@cols - 1)
    # detects neighbors to the east
    candidates << self.cell_grid[cell.y][cell.x + 1] if cell.x < (@cols - 1)
    # detects neighbors to the southeast
    candidates << self.cell_grid[cell.y + 1][cell.x + 1] if cell.y < (@rows - 1) && cell.x < (@cols - 1)
    # detects neighbors to the south
    candidates << self.cell_grid[cell.y + 1][cell.x] if cell.y < (@rows - 1)
    # detects neighbors to the southwest
    candidates << self.cell_grid[cell.y + 1][cell.x - 1] if cell.y < (@rows - 1) && cell.x > 0
    # detects neighbors to the west
    candidates << self.cell_grid[cell.y][cell.x - 1] if cell.x > 0
    #detects neighbors to the northwest
    candidates << self.cell_grid[cell.y - 1][cell.x - 1] if cell.y > 0 && cell.x > 0
    
    candidates.each {|candidate| live_neighbors << candidate if candidate.alive?}
    live_neighbors
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
  
  def reproduce!
    @alive = true
  end
  
  def die!
    @alive = false
  end
end