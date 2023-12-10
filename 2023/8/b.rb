Input = ARGF

class Array
  alias left first
  alias right last
end

instructions = Input.gets.chomp.chars

Input.gets # Consume the blank line

network = {}

Input.readlines.each do |line|
  line =~ /(\w\w\w) = \((\w\w\w), (\w\w\w)\)/

  node, left, right = $1, $2, $3

  network[node] = [left, right]
end

positions = network.keys.select { |k| k.end_with?('A') }

cycle_counts = positions.map do |position|
  steps = 0

  cycle = instructions.cycle

  until position.end_with?('Z')
    node = network[position]

    position = case cycle.next
               when 'L' then node.left
               when 'R' then node.right
               end

    steps += 1
  end

  steps
end

puts cycle_counts.inject :lcm
