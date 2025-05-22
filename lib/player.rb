class Player
    attr_accessor :name, :life_points
  
    def initialize(name)
        @name = name
        @life_points = 10
      end
    
      def show_state
        puts "#{@name} a #{@life_points} points de vie"
      end
    
      def gets_damage(damage)
        @life_points -= damage
        puts "le joueur #{@name} a été tué !" if @life_points <= 0
      end
    
      def attacks(player)
        puts "le joueur #{@name} attaque le joueur #{player.name}"
        damage = compute_damage
        player.gets_damage(damage)
        puts "il lui inflige #{damage} points de dommages"
      end
    
      def compute_damage
        return rand(1..6)
      end
    end
    
    # Nouvelle classe HumanPlayer
    class HumanPlayer < Player
        attr_accessor :weapon_level
      
        def initialize(name)
          @name = name
          @life_points = 100
          @weapon_level = 1
        end
      
        def show_state
            state = "#{@name} a #{@life_points} points de vie"
            @life_points > 50 ? state.colorize(:green) : state.colorize(:red)
          end
          
      
        def compute_damage
          rand(1..6) * @weapon_level
        end
      
        def search_weapon
          weapon_found = rand(1..6)
          puts "Tu as trouvé une arme de niveau #{weapon_found}"
          if weapon_found > @weapon_level
            @weapon_level = weapon_found
            puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
          else
            puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
          end
        end
      
        def search_health_pack
          dice_roll = rand(1..6)
      
          case dice_roll
          when 1
            puts "Tu n'as rien trouvé... "
          when 2..5
            puts "Bravo, tu as trouvé un pack de +50 points de vie !"
            @life_points += 50
            @life_points = 100 if @life_points > 100
          when 6
            puts "Waow, tu as trouvé un pack de +80 points de vie !"
            @life_points += 80
            @life_points = 100 if @life_points > 100
          end
        end
      end
      
    
  # Test HumanPlayer
puts "\nCréons un joueur humain..."
human = HumanPlayer.new("Jean-Michel Paladin")
human.show_state

  
  
  

  