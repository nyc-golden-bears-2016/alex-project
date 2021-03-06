get '/rounds/:id/new' do
  @played_cards_total = 0
  @game = Game.find(params[:id])
  @players = Player.all.where(game_id: @game.id)
  @round = Round.create(game_id: @game.id)
  @players.each do |player|
    Hand.create(player_id: player.id, round_id: @round.id, game_id: @game.id)
  end
  @deck = @game.decks.last
  Trick.create(round_id: @round.id)
  erb :'games/show'
end
