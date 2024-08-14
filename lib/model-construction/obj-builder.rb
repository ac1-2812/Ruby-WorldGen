module ModelConstruction
  class ObjBuilder
    def initialize verticies, output_file_name, object_name, smooth_shading
      @verticies = verticies
      @lines = []

      @rows = 0
      @columns = 0

      resolve_object_name_line object_name
      add_empty_line
      resolve_vertex_lines
      add_empty_line
      resolve_shading_line smooth_shading
      add_empty_line
      resolve_material_line
      add_empty_line
      resolve_face_lines

      File.write("models/#{output_file_name}.obj", @lines.join("\n"))
    end

    private

    def resolve_object_name_line object_name
      @lines.push "o #{object_name}"
    end

    def add_empty_line
      @lines.push ""
    end

    def resolve_vertex_lines
      @verticies.each do |vertex|
        @lines.push "v #{vertex.x} #{vertex.z} #{vertex.y}"

        @rows = vertex.x if vertex.x > @rows
        @columns = vertex.y if vertex.y > @columns
      end
    end

    def resolve_shading_line smooth_shading
      @lines.push "s #{smooth_shading ? "1" : "0"}"
    end

    def resolve_material_line
      @lines.push "usemtl Material"
    end

    def resolve_face_lines
      @rows += 1
      @columns += 1

      @rows.times do |row|
        (@columns - 1).times do |column|
          offset = row * @columns
          next_row_offset = (row + 1) * @columns

          @lines.push "f #{offset + 1 + column} #{offset + 2 + column} #{next_row_offset + 2 + column} #{next_row_offset + 1 + column}"
        end
      end
    end
  end
end