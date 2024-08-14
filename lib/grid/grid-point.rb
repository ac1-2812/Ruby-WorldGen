module Grid
  class GridPoint
    attr_accessor :x
    attr_accessor :y
    attr_accessor :z

    def initialize x, y, z = 0
      @x = x
      @y = y
      @z = z.to_f
    end
  end
end