eval File.read './a.rb'

module LowJoker
  def joker? = self == 'J'

  def rank = joker? ? 1 : super
end

Card.prepend LowJoker

module JokerWildcard
  def type
    if cards.any? &:joker?
      best_hand.type
    else
      super
    end
  end

  private

  def best_hand
    new_cards = cards.map { |card| card.joker? ? best_non_joker_card : card }

    self.class.new bid:, cards: new_cards
  end

  def best_non_joker_card
    non_joker_groups = groups.reject { _1.any? &:joker? }

    return Card.new 'A' if non_joker_groups.empty?

    best_group = non_joker_groups.sort_by { [_1.size, _1] }.last

    best_group.first
  end
end

Hand.prepend JokerWildcard
