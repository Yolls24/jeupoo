require 'bundler'
Bundler.require
require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'

# Création des joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")

# Boucle de combat
while player1.life_points > 0 && player2.life_points > 0
  puts "\nVoici l'état de nos joueurs :"
  player1.show_state
  player2.show_state

  puts "\nPassons à la phase d'attaque :"

  # Josiane attaque José
  player1.attacks(player2)

  # Vérification : si José est mort, on arrête tout
  break if player2.life_points <= 0

  # José contre-attaque
  player2.attacks(player1)

  puts "\n-----------------------------"
end

puts "\nLe combat est terminé !"

human = HumanPlayer.new("Jean-Michel Paladin")
human.show_state
human.search_health_pack
human.show_state

