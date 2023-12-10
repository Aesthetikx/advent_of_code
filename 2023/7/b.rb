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
    non_joker_groups = groups.reject { _1.any? &:joker? }

    best_group = non_joker_groups.sort_by { [_1.size, _1] }.last

    best_card = if best_group
                  best_group.first
                else
                  Card.new 'A'
                end

    new_cards = cards.map do |card|
      if card.joker?
        best_card
      else
        card
      end
    end

    self.class.new bid:, cards: new_cards
  end
end

Hand.prepend JokerWildcard
