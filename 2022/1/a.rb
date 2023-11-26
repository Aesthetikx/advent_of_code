# p ARGF.read.split("\n\n").map { |group| group.split.map(&:to_i).sum }.max

Elf = Data.define :calories do
  def <=> other
    calories <=> other.calories
  end
end

Input = ARGF.read

def Input.elves
  groups = split "\n\n"

  groups.map do |group|
    items = group.split.map &:to_i

    Elf.new calories: items.sum
  end
end

puts Input.elves.max.calories
