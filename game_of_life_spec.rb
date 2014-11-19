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
    end
    
    it "should create cell grid on initialization" do
      expect(subject.cell_grid.is_a?(Array)).to eq true
      subject.cell_grid.each {|row| expect(row.is_a?(Array)).to eq true}
      
      subject.cell_grid.each do |row|
        row.each {|col| expect(col.is_a?(Cell)).to eq true}
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
    context "Rule_one" do
      it "cause any live cell with less than two live neighbors to die" do
      end
    end
  end
end