require_relative("../grid/grid")
require_relative("../utility/dot-product")

module NoiseGeneration
  class PerlinNoiseGenerator
    def initialize scale = 2, smoothing = 1
      @scale = scale.to_f
      @smoothing = smoothing
    end

    public

    def generate_grid rows, columns, seed
      grid = Grid::Grid.new rows, columns
      
      generate_noise grid, seed
      grid.smooth @smoothing
      
      grid
    end

    private

    def generate_noise grid, seed
      index = 0;

      grid.grid_points.each do |grid_point|
        index += 1;

        offset_vector_1 = Random.new(seed + index).rand(0..@scale).to_f
        offset_vector_2 = Random.new(seed + index).rand(@scale..@scale * 2).to_f - @scale

        grid_point.z = (Utility::DotProduct.new.resolve [ @scale, @scale ], [ offset_vector_1, offset_vector_2 ])
      end
    end
  end
end