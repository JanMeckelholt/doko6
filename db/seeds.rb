# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if not Player.find_by(email: "ab@c1.de")
	player = Player.create!(email: "ab@c1.de", name: "Jan", password: "123456")
end
if not Player.find_by(email: "ab@c2.de")
    player = Player.create!(email: "ab@c2.de", name: "Peter", password: "123456")
end
if not Player.find_by(email: "ab@c3.de")
    player = Player.create!(email: "ab@c3.de", name: "Karl", password: "123456")
end
if not Player.find_by(email: "ab@c4.de")
    player = Player.create!(email: "ab@c4.de", name: "Klaus", password: "123456")
end


  CARDS = [
    "Herz_Zehn",
    "Kreuz_Dame",
    "Pik_Dame",
    "Herz_Dame",
    "Karo_Dame",
    "Kreuz_Bube",
    "Pik_Bube",
    "Herz_Bube",
    "Karo_Bube",
    "Karo_Ass",
    "Karo_Zehn",
    "Karo_Koenig",
    "Kreuz_Ass",
    "Kreuz_Zehn",
    "Kreuz_Koenig",
    "Pik_Ass",
    "Pik_Zehn",
    "Pik_Koenig",
    "Herz_Ass",
    "Herz_Koenig"
  ]

game = Game.create!
deck = Deck.create!(game: game)

CARDS.each do |card|
	Card.create!(name: card, deck: deck)
    Card.create!(name: card, deck: deck)
end