require_relative("grid/grid.rb")
require_relative("noise-generators/perlin-noise-generator.rb")
require_relative("model-construction/obj-builder.rb")

x = 257
y = 257

grid = Grid::Grid.new x, y

base_layer = NoiseGeneration::PerlinNoiseGenerator.new(14, 4).generate_grid(17, 17, 62)
base_layer.subdivide 4, 2

grid.apply(base_layer, 1)

detail_layer_1 = NoiseGeneration::PerlinNoiseGenerator.new(2.0, 10).generate_grid(129, 129, 325)
detail_layer_1.subdivide 1, 8

grid.apply(detail_layer_1, 0.4)

detail_layer_2 = NoiseGeneration::PerlinNoiseGenerator.new(5.0, 16).generate_grid(257, 257, 7654)
grid.apply(detail_layer_2, 0.2)

ModelConstruction::ObjBuilder.new(
  grid.grid_points,
  "perlin-model",
  "Perlin",
  false
)