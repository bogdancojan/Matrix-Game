require_relative 'spec_helper.rb'

describe Matrix do
  before(:each) do
    @matrix = Matrix.new(6, 6)
    @matrix.create
  end

  context do
    it "should create an image successfully" do
      expect(@matrix.is_a?(Object)).to eq(true) 
    end

    it "should clear the entire image successfully" do
      @matrix.clear
      matrix_cleared = true
      Matrix.matrix.each do |array|
        array.each {|element| matrix_cleared = false if element != "O"}
      end
      expect(matrix_cleared).to eq(true)
    end

    it "should colour the pixel successfully" do
      @matrix.colour_pixel(1, 1, "B")
      expect(Matrix.matrix[1][1]).to eq("B")
    end

    it "should draw a vertical segment successfully" do
      @matrix.vertical_segment(1, 1, 4, "B")
      vertical_line = true
      for i in 0..3
        vertical_line = false if Matrix.matrix[1+i][1] != "B"
      end
      expect(vertical_line).to eq(true)
    end

    it "should draw a horizontal segment successfully" do
      @matrix.horizontal_segment(1, 4, 1, "B")
      horizontal_line = true
      for i in 0..3
        horizontal_line = false if Matrix.matrix[1][1+i] != "B"
      end
      expect(horizontal_line).to eq(true)
    end
  end
end
