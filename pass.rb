grid = [
  [1,0,1],
  [1,1,1],
  [1,1,0]
]

visited = grid

visited.map!{|row|
  row.map!{|col|
    false
  }
}

puts grid
