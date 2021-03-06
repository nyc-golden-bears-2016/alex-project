class Hand < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
  has_many :cards

  after_save :deal_hand

  def deal_hand
    deck = Deck.find_by(round_id: self.round_id)
    if deck.nil?
      deck = Deck.create(game_id: self.game_id, round_id: self.round_id)
    end
    cards = deck.cards
    13.times do
      begin
        card = cards.sample
      end until card.hand_id.nil?
      card.hand_id = self.id
      card.player_id = self.player_id
      card.save
    end
  end

  def pick_card
  end

end
