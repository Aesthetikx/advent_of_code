eval File.read 'a.rb'

class Game
  def minimum_counts
    counts.group_by(&:color).transform_values do |colored_counts|
      colored_counts.map(&:number).max
    end
  end

  def power
    minimum_counts.values.inject :*
  end
end

puts Input.games.sum(&:power)
