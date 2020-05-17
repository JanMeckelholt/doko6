class GamePlayer < ApplicationRecord
	before_save :check_max_tricks, :check_max_game_players
	before_destroy :clear_tricks, :clear_hand
	

	belongs_to :player, optional: true
	belongs_to :game, optional: true
	
	has_one :hand, dependent: :destroy
	has_many :tricks, dependent: :destroy

	validates :tricks, length: { maximum: 10 }
	validates_associated :game

	

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

	private

	def check_max_tricks
		if self.tricks.any?
			if self.tricks.count<=10
				return true
			else
				errors.add(:base, "Spieler kann nur maximal 10 Stiche haben!")
				throw :abort
			end
		else
			return true
		end
	end

	def check_max_game_players
		if self.game 
			if self.game.game_players.count<4
				return true
			else
				if self.id
					game_player = GamePlayer.find(self.id)
		          if self.game.game_players.include? game_player #game is full but game_player already belongs to game
		          	return true
		          else #game is full and existing game_player can not be added
		          	errors.add(:base, "Spiel kann nur maximal 4 Spieler haben!")
		          	throw :abort
		          end
		        else #game is full and new game_player can not be added
		        	errors.add(:base, "Spiel kann nur maximal 4 Spieler haben!")
		        	throw :abort
		        end
		    end
		else 
      		return true #game_player without game
  		end
	end


end


