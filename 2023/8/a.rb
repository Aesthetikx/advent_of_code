Input = ARGF

class Array
  alias left first
  alias right last
end

sequence = Input.gets.chomp.chars.cycle

Input.gets # Consume the blank line

network = {}

Input.readlines.each do |line|
  line =~ /(\w\w\w) = \((\w\w\w), (\w\w\w)\)/

  node, left, right = $1, $2, $3

  network[node] = [left, right]
end

steps = 0

position = 'AAA'

until position == 'ZZZ'
  node = network[position]

  position = case sequence.next
             when 'L' then node.left
             when 'R' then node.right
             end

  steps += 1
end

puts steps
