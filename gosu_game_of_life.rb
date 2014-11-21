# gosu_game_file.rb
require "gosu"
require_relative "game_of_life.rb"

class Game_Window < Gosu::Window
  def initialize(height=600, width=800)
    @height = height
    @width = width
    super(width, height, false)
    self.caption = "Roman's Game of Life"
    
    #Color
    @background_color = Gosu::Color.new(0xffdedede)
    @alive_color = Gosu::Color.new(0xff000000)
    @dead_color = Gosu::Color.new(0xffdedede)
    
    @cols = width / 10
    @rows = height / 10
    
    @col_width = width / @cols
    @row_height = height / @rows

    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
    @game.world.randomly_populate
    
  end
  
  def update
    @game.tick!
  end
  
  def draw
    draw_quad(0, 0, @background_color,
              @width, 0, @background_color,
              @width, @height, @background_color,
              0, @height, @background_color)
              
    @game.world.cells.each do |cell|
      if cell.alive?
        draw_quad( cell.y * @row_height + 1, cell.x * @col_width + 1, @alive_color,
                  cell.y * @row_height - 1, (cell.x + 1) * @col_width - 1, @alive_color,
                  (cell.y + 1) * @row_height - 1, (cell.x + 1) * @col_width - 1, @alive_color,
                  (cell.y + 1) * @row_height - 1, cell.x * @col_width - 1, @alive_color)
      else
        draw_quad(cell.y * @row_height, cell.x * @col_width, @dead_color,
                  cell.y * @row_height, (cell.x + 1) * @col_width, @dead_color,
                  (cell.y + 1) * @row_height, (cell.x + 1) * @col_width, @dead_color,
                  (cell.y + 1) * @row_height, cell.x * @col_width, @dead_color)
      end
    end
  end
  
  def needs_cursor?
    true
  end
  
end

Game_Window.new.show