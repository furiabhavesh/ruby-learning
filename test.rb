def one_two_three(&block)
  yield 1
  yield 2
  yield 3
end
one_two_three { |number| puts number * 10 }

def explicit_block(&block)
  block.call # same as yield
end
explicit_block{ puts 'Hello' }

something = ->(x) { puts x * 5 }
something.call(10)
something.call(5)