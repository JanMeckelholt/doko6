Rails.application.routes.draw do
  devise_for :players
  root 'home#index'

  get 'home/index'



  get 'home/play'
  post 'home/create_game', to: 'home#create_game'
  post 'home/join_game', to: 'home#join_game'
  post 'home/leave_game', to: 'home#leave_game'
  post 'home/play_card', to: 'home#play_card'
end
