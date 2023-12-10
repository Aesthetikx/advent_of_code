eval File.read './a.rb'

positions = Network.keys.select { |k| k.end_with? 'A' }

cycle_counts = positions.map do |position|
  steps = 0

  directions = Sequence.cycle

  until position.end_with? 'Z'
    node = Network[position]

    position = case directions.next
               when 'L' then node.left
               when 'R' then node.right
               end

    steps += 1
  end

  steps
end

$answer = cycle_counts.inject :lcm
