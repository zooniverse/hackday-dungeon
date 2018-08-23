require "../spec_helper"

describe World do
  describe "at" do
    it "finds entity at coord" do
      world = World.new 5, 5
      player = world.spawn(1, 1, "bin/bot-nothing")
      world.at(Coord.new(1,1)).should eq([player])
    end

    it "finds nothing" do
      world = World.new 5, 5
      world.at(Coord.new(1,1)).should eq([] of Entity)
    end
  end

  describe "hitscan with a direction" do
    it "finds nothing" do
      world = World.new 5, 5
      world.hitscan(Coord.new(4, 4), Direction::West).should eq([] of Entity)
    end

    it "finds players" do
      world = World.new 5, 5
      player = world.spawn(4, 4, "bin/bot-nothing")
      enemy1 = world.spawn(3, 4, "bin/bot-nothing")
      enemy2 = world.spawn(2, 4, "bin/bot-nothing")
      enemy3 = world.spawn(0, 4, "bin/bot-nothing")
      world.hitscan(Coord.new(4, 4), Direction::West).should eq([enemy1, enemy2, enemy3])
    end
  end

  describe "hitscan between two coordinates" do
    it "finds nothing" do
      world = World.new 5, 5
      world.hitscan(Coord.new(4, 4), Coord.new(0, 4)).should eq([] of Entity)
      world.hitscan(Coord.new(4, 4), Coord.new(0, 0)).should eq([] of Entity)
    end

    it "finds players" do
      world = World.new 5, 5
      player = world.spawn(4, 4, "bin/bot-nothing")
      enemy1 = world.spawn(3, 4, "bin/bot-nothing")
      enemy2 = world.spawn(2, 4, "bin/bot-nothing")
      enemy3 = world.spawn(0, 4, "bin/bot-nothing")
      world.hitscan(Coord.new(4, 4), Coord.new(0, 4)).should eq([enemy1, enemy2, enemy3])
      world.hitscan(Coord.new(0, 4), Coord.new(4, 4)).should eq([enemy2, enemy1, player])
    end
  end
end
