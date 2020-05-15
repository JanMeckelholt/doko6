class GamePlayer < ApplicationRecord
	before_destroy :clear_tricks, :clear_hand

	belongs_to :player, optional: true
	belongs_to :game, optional: true
	
	has_one :hand, dependent: :destroy
	has_many :tricks, dependent: :destroy

	validates :tricks, length:{maximum: 10}

	

	def points
		point_sum = 0
		self.tricks.each do |trick|
			point_sum += trick.value_sum
		end
		return point_sum
	end

	def clear_tricks
		if self.tricks.any?
			self.tricks.each do |trick|
				if trick.cards.any?
					trick.cards.each do |card|
						card.update!(trick: nil)
					end    
				end
				trick.destroy!
			end  
		end
	end

	def clear_hand
		if self.hand
			if self.hand.cards.any?
				self.hand.cards.each do |card|
					card.update!(hand: nil)
				end  
			end
			self.hand.destroy!
		end
	end

end
