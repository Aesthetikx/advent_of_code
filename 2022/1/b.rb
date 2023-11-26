eval File.read './a.rb'

puts Input.elves.max(3).sum &:calories
