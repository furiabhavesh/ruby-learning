grid = [
  [1,0,1],
  [1,1,1],
  [1,1,0]
]
puts grid.to_s

visited = grid

visited.map!{|row|
  row.map!{|col|
    false
  }
}

puts grid.to_s

def get_size(grid, row_index, col_index)
  #puts "grid=#{grid}"
  # puts '1 found' if grid[row_index][col_index].eql?(1)
end

grid.each_with_index{|row, row_index|
  row.each_with_index{|col, col_index|
    get_size(grid, row_index, col_index)
  }
}
