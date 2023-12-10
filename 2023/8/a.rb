Input = ARGF

class Array
  alias left first
  alias right last
end

Sequence = Input.gets.chomp.chars

Input.gets # Consume the blank line

Network = {}

Input.readlines.each do |line|
  line =~ /(\w\w\w) = \((\w\w\w), (\w\w\w)\)/

  node, left, right = $1, $2, $3

  Network[node] = [left, right]
end

steps = 0

position = 'AAA'

directions = Sequence.cycle

until position == 'ZZZ'
  node = Network[position]

  position = case directions.next
             when 'L' then node.left
             when 'R' then node.right
             end

  steps += 1
end

$answer = steps

at_exit { puts $answer }
