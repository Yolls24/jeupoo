require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'
require 'colorize'

# Message d'accueil
puts "------------------------------------------------".colorize(:light_blue)
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !    |".colorize(:light_blue)
puts "| Le but du jeu est d'être le dernier survivant ! |".colorize(:light_blue)
puts "------------------------------------------------\n\n".colorize(:light_blue)

# Création du joueur humain
puts "Quel est ton prénom, jeune combattant ?".colorize(:yellow)
print "> "
user_name = gets.chomp
user = HumanPlayer.new(user_name)
puts "\n"

# Création des ennemis
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

# Boucle de combat
while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts "\n#{'-' * 30}".colorize(:light_black)
  user.show_state
  puts "\nQuelle action veux-tu effectuer ?".colorize(:green)
  puts "a - chercher une meilleure arme".colorize(:cyan)
  puts "s - chercher à se soigner".colorize(:cyan)
  puts "\nattaquer un joueur en vue :".colorize(:red)

  enemies.each_with_index do |enemy, index|
    if enemy.life_points > 0
      puts "#{index} - #{enemy.show_state}"
    end
  end

  print "\n> ".colorize(:light_yellow)
  action = gets.chomp

  puts "\n"
  case action
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  when "0"
    user.attacks(player1) if player1.life_points > 0
  when "1"
    user.attacks(player2) if player2.life_points > 0
  else
    puts "Commande inconnue. Essaie 'a', 's', '0' ou '1'.".colorize(:light_red)
  end

  puts "\nAppuie sur Entrée pour continuer...".colorize(:light_black)
  gets.chomp

  # Riposte des ennemis
  puts "\nLes autres joueurs t'attaquent !".colorize(:red)
  enemies.each do |enemy|
    enemy.attacks(user) if enemy.life_points > 0
  end

  puts "\nAppuie sur Entrée pour continuer...".colorize(:light_black)
  gets.chomp
end

# Fin du jeu
puts "\n#{'-' * 30}".colorize(:light_black)
puts "La partie est finie".colorize(:light_blue)
if user.life_points > 0
  puts "🎉 BRAVO ! TU AS GAGNÉ ! 🎉".colorize(:green)
else
  puts "💀 Loser ! Tu as perdu ! 💀".colorize(:red)
end


