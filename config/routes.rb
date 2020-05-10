Rails.application.routes.draw do
  devise_for :players
  root 'home#index'

  get 'home/index'



  get 'home/play'
  get 'home/create_game', to: 'home#create_game'
  get 'home/join_game', to: 'home#join_game'
  get 'home/leave_game', to: 'home#leave_game'
  get 'home/play_card', to: 'home#play_card'
end
