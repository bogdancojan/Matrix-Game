class Matrix
  @@matrix = Array.new
  attr_accessor :lines, :columns

  def initialize(lines, columns)
    @lines = lines
    @columns = columns
  end

  def self.matrix
    @@matrix
  end

  def create
    @lines.times do 
      array = Array.new
      @columns.times {array.push("O")}
      @@matrix.push(array)
    end
  end

  def show
    @@matrix.each do |array|
      array.each {|element| print element}
      puts
    end
  end

  def clear
    @@matrix.each do |array|
      array.map! {|element| element = "O"}
    end
  end

  def colour_pixel(x, y, color)
    @@matrix[x][y] = color
  end

  def vertical_segment(x, y1, y2, color)
    @@matrix[y1][x] = color
    while true 
      if @@matrix[y2][x] != color
        vertical_segment(x, y1+1, y2, color)
      else break end
    end
  end

  def horizontal_segment(x1, x2, y, color)
    @@matrix[y][x1] = color
    while true
      if @@matrix[y][x2] != color
        horizontal_segment(x1+1, x2, y, color)
      else break end
    end
  end
end

puts "type ? for help..."
opt = gets.chomp.to_s
if opt == "?"
  while true
    puts "? - Help."
    puts "    I M N - Create a new M x N image with all pixels coloured white (O)."
    puts "    C - Clears the table, setting all pixels to white (0)."
    puts "    L X Y C - Colours the pixel (X, Y) with colour C."
    puts "    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)."
    puts "    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)."
    puts "    S - Show the contents of the current image."
    puts "    X - Terminate the session."
    opt = gets.chomp.delete(' ')

    case
    when "I" === opt[0]
      matrix = Matrix.new(opt[1].to_i, opt[2].to_i)
      matrix.create; puts
    when "C" === opt
      matrix.clear; puts
    when "L" === opt[0]
      if(opt[1].to_i <= matrix.lines && opt[2].to_i <= matrix.columns)
        matrix.colour_pixel(opt[1].to_i - 1, opt[2].to_i - 1, opt[3]); puts
      else
        puts "\nInvalid range...\n\n"
      end
    when "V" === opt[0]
      if(opt[1].to_i <= matrix.columns && opt[2].to_i >= 1 && opt[3].to_i <= matrix.lines)
        matrix.vertical_segment(opt[1].to_i - 1, opt[2].to_i - 1, opt[3].to_i - 1, opt[4]); puts
      else
        puts "\nInvalid range...\n\n"
      end
    when "H" === opt[0]
      if(opt[1].to_i >= 1 && opt[2].to_i <= matrix.columns && opt[3].to_i <= matrix.lines)
        matrix.horizontal_segment(opt[1].to_i - 1, opt[2].to_i - 1, opt[3].to_i - 1, opt[4]); puts
      else
        puts "\nInvalid range...\n\n"
      end
    when "S" === opt
      matrix.show; puts
    when "X" === opt then break
    else opt
      puts "\nWrong key...\n\n"
    end
  end
else
  puts "Wrong key..."
end
