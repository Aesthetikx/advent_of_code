eval File.read './a.rb'

class AssignmentPair
  def overlap?
    one.include? two.first or two.include? one.first
  end
end

puts Input.assignment_pairs.count &:overlap?
