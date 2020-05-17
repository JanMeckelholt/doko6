class Trick < ApplicationRecord
	before_save :check_max_cards, :check_max_tricks_on_game_player, :check_max_tricks_on_game
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


	def check_max_tricks_on_game
		if self.game
			if self.game.tricks.count<10
				return true
			else
				if self.id
					trick = Trick.find(self.id)
		          if self.game.tricks.include? trick #game is full but trick already belongs to game
		          	return true
		          else #game is full and existing trick can not be added
		          	errors.add(:base, "Ein Spiel kann nur maximal 10 Stiche haben!")
		          	throw :abort
		          end
		        else #game is full and new trick can not be added
		        	errors.add(:base, "Ein Spiel kann nur maximal 10 Stiche haben!")
		        	throw :abort
		        end
		    end
		else 
		    return true #trick without game
		end
	end



	def check_max_tricks_on_game_player
		if self.game_player
			if self.game_player.tricks.count<10
				return true
			else
				if self.id
					trick = Trick.find(self.id)
		          if self.game_player.tricks.include? trick #game_player is full but trick already belongs to game
		          	return true
		          else #game_player is full and existing trick can not be added
		          	errors.add(:base, "Spieler kann nur maximal 10 Stiche haben!")
		          	throw :abort
		          end
		        else #game_player is full and new trick can not be added
		        	errors.add(:base, "Spieler kann nur maximal 10 Stiche haben!")
		        	throw :abort
		        end
		    end
		else 
		    return true #trick without game_player
		end
	end










