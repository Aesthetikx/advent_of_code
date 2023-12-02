Input = ARGF.read

class Object
  def ! = method :<<
end

def Input.games = split("\n").map &!Game

class Game < Data.define :id, :rounds
  def self.<< line
    line.gsub! /Game (\d+): /, ''

    id = $1.to_i

    rounds = line.gsub(/.*: /, '').split('; ').map &!Round

    new id:, rounds:
  end

  def possible? = rounds.all? &:possible?
end

class Round < Data.define :counts
  def self.<< string
    counts = string.split(', ').map &!Count

    new counts:
  end

  def possible? = counts.all? &:possible?
end

class Count < Data.define :color, :number
  def self.<< string
    number, color = string.split

    new color: color.to_sym, number: number.to_i
  end

  def possible? = number <= { red: 12, green: 13, blue: 14 }[color]
end

puts Input.games.select(&:possible?).sum &:id
