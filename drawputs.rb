require "gosu"

class GameWindow < Gosu::Window
  def initialize
    super(800, 800, false)
  end
  def draw
    puts "Hello world"
  end
end

test = GameWindow.new
test.show