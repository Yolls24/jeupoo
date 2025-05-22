class Game
    attr_accessor :human_player, :enemies_in_sight, :players_left
  
    def initialize(name)
      puts "Initialisation de Game avec le nom : #{name}"
      @human_player = HumanPlayer.new(name)
      @enemies_in_sight = []
      @players_left = 10
    end
  
    def kill_player(player)
      @enemies_in_sight.delete(player)
    end
  
    def is_still_ongoing?
      @human_player.life_points > 0 && (@players_left > 0)
    end
  
    def show_players
      puts "\n#{'-' * 30}".colorize(:light_blue)
      @human_player.show_state
      puts "Il reste #{@players_left} ennemis à éliminer.".colorize(:magenta)
      puts "Ennemis en vue : #{@enemies_in_sight.size}".colorize(:magenta)
    end
  
    def menu
      puts "\nQuelle action veux-tu effectuer ?".colorize(:green)
      puts "a - chercher une meilleure arme".colorize(:cyan)
      puts "s - chercher à se soigner".colorize(:cyan)
      puts "\nattaquer un joueur en vue :".colorize(:red)
  
      @enemies_in_sight.each_with_index do |enemy, index|
        if enemy.life_points > 0
          puts "#{index} - #{enemy.show_state}"
        end
      end
    end
  
    def menu_choice(choice)
      if choice == "a"
        @human_player.search_weapon
      elsif choice == "s"
        @human_player.search_health_pack
      elsif choice.to_i.to_s == choice
        index = choice.to_i
        if enemy = @enemies_in_sight[index]
          @human_player.attacks(enemy)
          if enemy.life_points <= 0
            kill_player(enemy)
            @players_left -= 1
          end
        else
          puts "Cet ennemi n'existe pas !".colorize(:light_red)
        end
      else
        puts "Commande inconnue !".colorize(:light_red)
      end
    end
  
    def enemies_attack
      puts "\nLes ennemis contre-attaquent !".colorize(:red)
      @enemies_in_sight.each do |enemy|
        enemy.attacks(@human_player) if enemy.life_points > 0
      end
    end
  
    def new_players_in_sight
      if @enemies_in_sight.length >= @players_left
        puts "Tous les joueurs sont déjà en vue.".colorize(:light_blue)
        return
      end
  
      dice = rand(1..6)
      case dice
      when 1
        puts "Aucun nouvel adversaire n'arrive... pour l'instant.".colorize(:light_black)
      when 2..4
        add_enemy(1)
      when 5..6
        add_enemy(2)
      end
    end
  
    def add_enemy(number)
      number.times do
        break if @enemies_in_sight.length >= @players_left
  
        new_id = rand(1000..9999)
        new_enemy = Player.new("joueur_#{new_id}")
        @enemies_in_sight << new_enemy
        puts "⚠️ Un nouvel ennemi arrive en vue : #{new_enemy.name} !".colorize(:red)
      end
    end
  
    def game_over
      puts "\n#{'-' * 30}".colorize(:light_blue)
      puts "La partie est finie.".colorize(:light_blue)
      if @human_player.life_points > 0
        puts "🎉 BRAVO ! TU AS GAGNÉ ! 🎉".colorize(:green)
      else
        puts "💀 Tu as perdu... Loser ! 💀".colorize(:red)
      end
    end
  end
  