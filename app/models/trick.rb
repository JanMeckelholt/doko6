class Trick < ApplicationRecord
	before_save :check_max_cards
	belongs_to :game, optional: true
	belongs_to :game_player, optional: true
	has_many :cards

	validates :cards, length:{maximum: 4}
	validates_associated :game_player, :game

	def value_sum
		sum = 0
		self.cards.each do |card|
			sum += card.point_value
		end
		return sum

	end

	private

	def check_max_cards
		if self.cards.any?
			if self.cards.count<=4
				return true
			else
				errors.add(:base, "Stich kann nur maximal 4 Karten haben!")
				throw :abort
			end
		else
			return true
		end
	end

end
