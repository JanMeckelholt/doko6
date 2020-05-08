class HomeController < ApplicationController

before_action :authenticate_player!



   def index
    @current_player = current_player
    @game = Game.all.first || Game.create!
    find_players 
  end #index

  def join_game
    @current_player = current_player
   # byebug
    @game = Game.all.first || Game.create!
    find_players
    if @players.include? @current_player
      flash[:alert] = "You already joined!"
    else
      @game_player = GamePlayer.find_or_create_by!(game: @game, player: @current_player)
      find_players
    
      ActionCable.server.broadcast "game_channel", sent_by: @current_player.name_or_email, content: "Joining"
     # ActionCable.server.broadcast "appreance_channel", content: @current_player.name_or_email
     # GameChannel.broadcast_to(@curren_player, content: @current_player.name_or_email)
   
    end
    #if @players.count == 4 
    #  create_game
    #else
      redirect_to :home_index
    #end
  end

  def leave_game
    @current_player = current_player
    if @current_player.hand
      @current_player.hand.cards.each do |card|
        card.update!(hand: nil)
      end
      @current_player.hand.destroy!
    end
    @current_player.update(game: nil, hand:nil)
    redirect_to :home_index
  end  



  def play
    @current_player = current_player
    if GamePlayer.find_by(player: @current_player)
      @game = GamePlayer.find_by(player: @current_player).game
      find_players
    else 
      redirect_to :home_index
    end
  end #play

  def create_game 
    @game = Game.all.first || Game.create!
    reset_game
    @current_player = current_player
    if params[:players]
      find_players_by_params
    end
    @players.each do |player|
      @game_player = GamePlayer.create!(game: @game, player: player)
    end
    @deck = Deck.all.first || Deck.create!
    @deck.update!(game: @game)
    @deck.build_deck
    init_players
    @trick = Trick.create!(game: @game)
    redirect_to :home_play
  end #create

  def play_card
    @card = Card.find(params[:card])
    @current_player = current_player
    @game = Game.find(params[:game])
    find_players
    if (@game.player_to_play(@players)==@current_player) && (@current_player.hand.cards.count + @game.round == 10)
      @card.update!(trick: @game.trick, played: true)
      @game.to_next_player
      @game.save
      ActionCable.server.broadcast "game_channel", content: @card.name
    else
      flash[:alert] = 'Not your turn!'
      #byebug
    end
    #byebug
    redirect_to :home_play
  end



private


  
  def find_players
    @players = []
    @player_ids = GamePlayer.where(game_id: @game.id).distinct.pluck(:player_id) || []
    @player_ids.each do |player_id|
      @players << Player.find(player_id)
    end  
  end #find_players

  def find_players_by_params
    @players = []
    params[:players].each do |player_id|
      @players << Player.find(player_id)
    end
  end

  def init_players
    @players.each do |player|
      #hand = Hand.new(player: player)
      hand = Hand.find_or_create_by!(player: player)
      @deck.deal_to(hand)
      hand.save
      player.save
    end
  end #init_players

  def destroy_player_hands
    find_players
    @players.each do |player|
      if player.hand
        player.hand.cards.each do |card|
          card.update!(hand: nil)
        end
        player.hand.destroy!
      end
    end
  end

  def destroy_game_players
    find_players
    @players.each do |player|
      player.game_player.destroy!  
    end 
  end 

  def destroy_trick
    if @game.trick
      @game.trick.cards.each do |card|
          card.update!(trick: nil)
      end
      @game.trick.destroy!
    end
  end


  def reset_game
    @game.update!(round: 0, next_player:1)
    destroy_trick
    destroy_player_hands
    destroy_game_players
  end


end
