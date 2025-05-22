require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

# --- Message de bienvenue ---
puts "-" * 50
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' ! |".colorize(:light_blue)
puts "| Le but du jeu est d'être le dernier survivant ! |".colorize(:light_blue)
puts "-" * 50

# --- Demande le nom du joueur ---
puts "\nQuel est ton prénom, jeune combattant ?".colorize(:yellow)
print "> "
user_name = gets.chomp

# --- Initialise le jeu avec l'objet Game ---
my_game = Game.new(user_name)

# --- Boucle de combat ---
while my_game.is_still_ongoing?
    puts "\n#{'=' * 30}".colorize(:light_blue)
    my_game.new_players_in_sight # 👈 Ici !
    my_game.show_players
    puts "\n#{'-' * 30}".colorize(:light_blue)
    my_game.menu
  puts "\nQuelle action choisis-tu ?".colorize(:light_yellow)
  print "> "
  choice = gets.chomp
  my_game.menu_choice(choice)

  puts "\nAppuie sur Entrée pour passer au tour des ennemis...".colorize(:light_black)
  gets.chomp

  my_game.enemies_attack if my_game.is_still_ongoing?

  puts "\nAppuie sur Entrée pour continuer...".colorize(:light_black)
  gets.chomp
end

# --- Fin du jeu ---
my_game.game_over


