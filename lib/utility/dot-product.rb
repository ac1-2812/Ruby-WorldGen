module Utility
  class DotProduct
    def resolve n_dimensional_array_1, n_dimensional_array_2
      result = 0;

      n_dimensional_array_1.length.times { |index| result += n_dimensional_array_1[index] * n_dimensional_array_2[index] }

      result
    end
  end
end