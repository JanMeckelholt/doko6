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
      flash[:danger] = "You already joined!"
    else
      @game_player = GamePlayer.find_or_create_by!(game: @game, player: @current_player)
      find_players
      if @players.count == 4 
        create_game
        ActionCable.server.broadcast "player_channel", content: "play", sent_by: @current_player.id
      else
        ActionCable.server.broadcast "player_channel", content: "reload", sent_by: @current_player.id
      end
     # ActionCable.server.broadcast "game_channel", content: "tach game"
     # ActionCable.server.broadcast "appreance_channel", content: @current_player.name_or_email
     # GameChannel.broadcast_to(@curren_player, content: @current_player.name_or_email)
    end
    redirect_to :home_index
  end

  def leave_game
    @current_player = current_player
    if @current_player.hand
      @current_player.hand.cards.each do |card|
        card.update!(hand: nil)
      end  
    end
    @current_player.game_player.destroy! if @current_player.game_player
    ActionCable.server.broadcast "player_channel", content: "reload", sent_by: @current_player.id
    redirect_to :home_index
  end  



  def play
    @current_player = current_player
    @game = @current_player.game
    if @game  
      find_players
    else 
      redirect_to :home_index
    end
  end #play

  def create_game 
    @game = Game.all.first || Game.create!
    @game.update!(round: 0, next_player:1)
    destroy_game_tricks
    destroy_player_tricks
    destroy_player_hands
    @current_player = current_player
  #  if params[:players]
  #    find_players_by_params
  #  end
  #  @players.each do |player|
  #    @game_player = GamePlayer.create!(game: @game, player: @current_player)
  #  end
    @deck = Deck.all.first || Deck.create!
    @deck.update!(game: @game)
    @deck.build_deck
    find_players
    init_players
    @trick = Trick.create!(game: @game)
    #redirect_to :home_play
  end #create

  def play_card
    @card = Card.find(params[:card])
    @current_player = current_player
    @game = Game.find(params[:game])
    find_players
    if (@game.player_to_play(@players)==@current_player) && (@current_player.hand.cards.count + @game.round == 10)
      @card.update!(trick: @game.tricks.last, played: true)
      @game.to_next_player
      @game.save
      ActionCable.server.broadcast "game_channel", content: "reload"
    else
      flash[:danger] = 'Not your turn!'
      #byebug
    end
    #byebug
    redirect_to :home_play
  end

  def claim_trick
    @current_player = current_player
    @game.tricks.last.player = @current_player
    if @game.round < 10
      @game.trick.create!
      @game.to_next_player
      ActionCable.server.broadcast "game_channel", content: "reload"
    end
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
      hand = Hand.find_or_create_by!(game_player: player.game_player)
      @deck.deal_to(hand)
      hand.save
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

  def destroy_game_tricks
    @game.tricks.each do |trick|
      trick.cards.each do |card|
          card.update!(trick: nil)
      end
      trick.destroy!
    end
  end

  def destroy_player_tricks
    find_players
    @players.each do |player|
      player.tricks.each do |trick|
        trick.cards.each do |card|
            card.update!(trick: nil)
        end
        trick.destroy!
      end
    end
  end


  def reset_game
    @game.update!(round: 0, next_player:1)
    destroy_game_tricks
    destroy_player_hands
    destroy_game_players
  end


end
