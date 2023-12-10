module Enumerable
  def two? = size == 2

  def three? = size == 3

  def four? = size == 4
end

class Card < String
  def rank
    case self
    when 'A' then 14
    when 'K' then 13
    when 'Q' then 12
    when 'J' then 11
    when 'T' then 10
    else to_i end
  end

  def <=> other
    rank <=> other.rank
  end
end

class Hand < Data.define :cards, :bid
  def <=> other
    if type == other.type
      cards <=> other.cards
    else
      type <=> other.type
    end
  end

  protected

  def type
    if five_of_a_kind?
      6
    elsif four_of_a_kind?
      5
    elsif full_house?
      4
    elsif three_of_a_kind?
      3
    elsif two_pairs?
      2
    elsif one_pair?
      1
    else
      0
    end
  end

  def five_of_a_kind? = groups.one?

  def four_of_a_kind? = groups.any? &:four?

  def full_house? = groups.two?

  def three_of_a_kind? = groups.any? &:three?

  def two_pairs? = pairs.two?

  def one_pair? = pairs.one?

  def groups
    cards.group_by(&:rank).values
  end

  def pairs
    groups.select &:two?
  end
end

hands = ARGF.readlines.map do |line|
  left, right = line.split

  cards = left.chars.map { |card| Card.new card }

  bid = right.to_i

  Hand.new cards:, bid:
end

at_exit do
  score = hands.sort.each_with_index.map do |hand, i|
    rank = i + 1

    hand.bid * rank
  end.sum

  puts score
end
