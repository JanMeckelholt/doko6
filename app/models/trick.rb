class Trick < ApplicationRecord
	belongs_to :game, optional: true
	has_many :cards

	validates :cards, length:{maximum: 4}
end
