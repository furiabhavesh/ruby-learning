# In Ruby, sometimes expressions are surrounded by vertical bars, "|like this|". Extend your validator to validate vertical bars. Careful: there's no difference between the "opener" and "closer" in this case—they're the same character!

require 'set'

def valid?(code)

  openers_to_closers = {
    '(' => ')',
    '{' => '}',
    '[' => ']'
  }

  openers = openers_to_closers.keys.to_set
  closers = openers_to_closers.values.to_set

  puts openers.to_s

  openers_stack = []

  code.chars.each do |char|
    if openers.include?(char)
      openers_stack.push(char)
    elsif closers.include?(char)
      if openers_stack.empty?
        return false
      else
        last_unclosed_opener = openers_stack.pop

        # If this closer doesn't correspond to the most recently
        # seen unclosed opener, short-circuit, returning false.
        if openers_to_closers[last_unclosed_opener] != char
          return false
        end
      end
    end
  end
  openers_stack.empty?
end

valid?("({")