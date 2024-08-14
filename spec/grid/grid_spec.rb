require('grid/grid.rb')

RSpec.describe Grid::Grid, "#initialize" do
  context "when initializing a 3x3 grid" do
    it "contains 9 grid points" do
      grid = Grid::Grid.new 3, 3

      expect(grid.grid_points.length).to eq 9
    end
  end
end

RSpec.describe Grid::Grid, "#floor" do
  context "when flooring a grid" do
    it "will lower the z value of all points by the lowest z value" do
      grid = Grid::Grid.new 3, 3

      grid.grid_points.each do |point|
        point.z = Random.new.rand(10..19)
      end

      grid.floor

      lowest_z = 10;
      highest_z = 0;

      grid.grid_points.each do |point|
        lowest_z = point.z if point.z < lowest_z
        highest_z = point.z if point.z > highest_z
      end

      expect(lowest_z).to eq 0
      expect(lowest_z).to be_between 0, 9
    end
  end
end

RSpec.describe Grid::Grid, "#smooth" do
  context "when smoothing a grid" do
    it "z values become the average from a cross section of points" do
      grid = Grid::Grid.new 2,2

      grid.grid_points[0].z = 1.0
      grid.grid_points[1].z = 1.0

      grid.grid_points[2].z = 1.0
      grid.grid_points[3].z = 2.0

      grid.smooth 1

      p grid.grid_points

      expect(grid.grid_points[0].z.round(3)).to eq 1
      expect(grid.grid_points[1].z.round(3)).to eq 1.333
      expect(grid.grid_points[2].z.round(3)).to eq 1.333
      expect(grid.grid_points[3].z.round(3)).to eq 1.556
    end
  end
end

RSpec.describe Grid::Grid, "#subdivision" do
  context "when subdividing a grid" do
    it "will get x - 1 additional columns and rows" do
      grid = Grid::Grid.new 2,2

      grid.subdivide 1, 0
      
      expect(grid.grid_points.length).to eq 9
      
      grid.subdivide 1, 0
      
      expect(grid.grid_points.length).to eq 25
    end
  end
end