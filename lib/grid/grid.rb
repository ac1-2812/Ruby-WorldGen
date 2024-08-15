class Grid
  attr_reader :rows
  attr_reader :columns

  attr_reader :grid_points

  def initialize rows, columns
    @rows = rows
    @columns = columns
    @grid_points = []

    rows.times do |row|
      columns.times do |column|
        @grid_points.push GridPoint.new(row, column)
      end
    end
  end

  public

  def floor
    min_floor = @grid_points[0].z

    @grid_points.each do |item|
      min_floor = item.z if min_floor > item.z
    end

    @grid_points.each do |item|
      item.z -= min_floor
    end
  end

  def apply grid, strength
    index = 0

    grid.grid_points.each do |grid_point|
      @grid_points[index].z += (grid_point.z.to_f + 1) * strength.to_f
      index += 1
    end

    floor
  end

  def subdivide iterations, smoothing
    iterations.times do
      new_grid_points = []
      new_columns = 0
      new_rows = 0

      @rows.times do |row|
        rows_to_add = row + 1 == @rows ? 1 : 2

        rows_to_add.times do |row_offset|
          new_rows += 1
          new_columns = 0

          @columns.times do |column|
            offset = column * 2
            current_index = (row * @columns) + column;
            
            new_grid_points.push GridPoint.new row_offset + row, offset, @grid_points[current_index].z
            new_columns += 1

            unless column + 1 == @columns
              new_grid_points.push GridPoint.new row_offset + row, offset + 1, @grid_points[current_index].z
              new_columns += 1
            end
          end
        end
      end

      @columns = new_columns
      @rows = new_rows
      @grid_points = new_grid_points
      smooth smoothing
    end
  end

  def smooth iterations
    iterations.times do
      @rows.times do |row|
        @columns.times do |column|
          offset = (row * @columns) + column
          smoothing_array = resolve_smoothing_array row, column, offset

          new_val = 0;

          smoothing_array.each { |item| new_val += @grid_points[item].z }
          @grid_points[offset].z = new_val / smoothing_array.length
        end
      end
    end
  end

  private

  def resolve_smoothing_array row, column, offset
    smoothing_array = [
      offset
    ]

    smoothing_array.push offset - 1 unless offset == 0
    smoothing_array.push offset - @columns unless row == 0
    smoothing_array.push offset + 1 unless column + 1 == @columns
    smoothing_array.push offset + @columns unless row + 1 == @rows

    smoothing_array
  end
end