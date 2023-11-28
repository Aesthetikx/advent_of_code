Input = ARGF.read

AssignmentPair = Data.define :one, :two do
  def cover?
    one.cover? two or two.cover? one
  end
end

def AssignmentPair.parse line
  a1, a2, b1, b2 = line.split(/-|,/).map &:to_i

  new a1..a2, b1..b2
end

def Input.assignment_pairs
  each_line.map &AssignmentPair.method(:parse)
end

puts Input.assignment_pairs.count &:cover?
