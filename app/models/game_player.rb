class GamePlayer < ApplicationRecord

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


end
