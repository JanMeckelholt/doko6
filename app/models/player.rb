class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  has_one :game_player, dependent: :destroy  
  has_one :game,  :through => :game_player
  has_one :hand, dependent: :destroy
end
