class Hand < ApplicationRecord
	before_save :check_max_cards
	has_many :cards, -> { order(id: :asc) }  
	belongs_to :game_player, optional: true

	validates :cards, length:{maximum: 10}



	def not_played
		self.cards.where(played: false)
	end



	private

	def check_max_cards
		if self.cards.any?
			if self.cards.count<=10
				return true
			else
				errors.add(:base, "Spieler kann nur maximal 10 Karten auf der Hand haben!")
				throw :abort
			end
		else
			return true
		end
	end




end
