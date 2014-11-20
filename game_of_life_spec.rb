# spec/game_of_life_spec.rb
require "rspec"
require_relative "game_of_life.rb"

describe "Game_of_Life" do
  let(:world) { World.new }
  
  context "World" do
    subject { World.new }
    
    it "should create a new World object" do
      expect(subject.is_a?(World)).to eq true
    end
    it "should respond to proper methods" do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
      expect(subject).to respond_to(:neighbors)
    end
    
    it "should create cell grid on initialization" do
      expect(subject.cell_grid.is_a?(Array)).to eq true
      subject.cell_grid.each {|row| expect(row.is_a?(Array)).to eq true}
      
      subject.cell_grid.each do |row|
        row.each {|col| expect(col.is_a?(Cell)).to eq true}
      end
    end
    
    context "#cells" do
      it "should add all cells in the grid" do
        expect(subject.cells.length).to eq 9
      end
    end
    context "#neighbors" do
      it "should detect a neighbor to the north" do
        subject.cell_grid[0][1].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end
      it "should detect a neighbor to the south" do
        subject.cell_grid[2][1].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end
      it "should detect a neighbor to the east" do
        subject.cell_grid[1][2].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end
      it "should detect a neighbor to the west" do
        subject.cell_grid[1][0].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end
      it "should detect a neighbor to the northeast" do
        subject.cell_grid[0][2].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end
      it "should detect a neighbor to the northwest" do
        subject.cell_grid[0][0].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end
      it "should detect a neighbor to the southeast" do
        subject.cell_grid[2][2].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end
      it "should detect a neighbor to the southwest" do
        subject.cell_grid[2][0].alive = true
        expect(subject.neighbors(subject.cell_grid[1][1]).length).to eq 1
      end

    end
  end
  
  context "Cell" do
    subject { Cell.new }
    
    it "should create a new Cell objects" do
      expect(subject.is_a?(Cell)).to eq true
    end
    
    it "should respond to proper methods" do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
      expect(subject).to respond_to(:alive?)
    end
    
    it "should initialize properly" do
      expect(subject.alive).to eq false
      expect(subject.y).to eq 0
      expect(subject.x).to eq 0
    end
    
  end
  
  context "Game" do
    subject {Game.new}
    
    it "should create a new game object" do
      expect(subject.is_a?(Game)).to eq true
    end
    
    it "should respond to proper methods" do
      expect(subject).to respond_to(:world)
      expect(subject).to respond_to(:seeds)
    end
    
    it "should initialize properly" do
      expect(subject.world.is_a?(World)).to eq true
      expect(subject.seeds.is_a?(Array)).to eq true
    end
    
    it "should plant seeds properly" do
    game = Game.new(world, [[1, 2], [0, 2]])
    expect((world.cell_grid[1][2]).alive).to eq true
    expect((world.cell_grid[0][2]).alive).to eq true
    end
  end
  
  context "Rules" do
    let(:game) { Game.new }
    context "rule_one" do
      it "cause any live cell with less than two live neighbors to die" do
        game = Game.new(world, [[1,0],[2,0]])
        game.tick!
        expect(world.cell_grid[1][0].alive?).to eq false
        expect(world.cell_grid[2][0].alive?).to eq false
      end
    end
    context "rule_two" do
      it "any live cell with two live neighbors lives next turn" do
        game = Game.new(world, [[1,0],[1,1],[2,0]])
        game.tick!
        expect(world.cell_grid[1][0].alive?).to eq true
        expect(world.cell_grid[1][1].alive?).to eq true
        expect(world.cell_grid[2][0].alive?).to eq true      
      end
      it "any live cell with three live neighbors lives next turn" do
        game = Game.new(world, [[1,0],[1,1],[2,0],[2,1]])
        game.tick!
        expect(world.cell_grid[1][0].alive?).to eq true
        expect(world.cell_grid[1][1].alive?).to eq true
        expect(world.cell_grid[2][0].alive?).to eq true
        expect(world.cell_grid[2][1].alive?).to eq true
      end
    end
    context "rule_three" do
      it "kills a cell with more than three live neighbors" do
        game = Game.new(world, [[0,0],[1,0],[1,1],[2,0],[2,1]])
        game.tick!
        expect(world.cell_grid[1][0].alive?).to eq false
        expect(world.cell_grid[1][1].alive?).to eq false
      end
    end
    context "rule_four" do
      it "brings a dead cell to life it has exactly three live neighbors" do
        game = Game.new(world, [[0,0],[1,0],[1,1],[2,0],[2,1]])
        game.tick!
        expect(world.cell_grid[0][1].alive?).to eq true
      end
    end
  end
end