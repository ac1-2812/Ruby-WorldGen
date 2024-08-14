require('utility/dot-product.rb')

RSpec.describe Utility::DotProduct, "#resolve" do
  context "when providing  [ 1, 3, -5 ], [ 4, -2, -1 ]" do
    it "resolves the dot product for the arrays" do
      dot_product = Utility::DotProduct.new

      expect(dot_product.resolve [ 1, 3, -5 ], [ 4, -2, -1 ]).to eq 3
    end
  end
end