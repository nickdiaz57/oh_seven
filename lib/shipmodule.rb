module ShipMethods
    
    def ship_info
        ship_options
        choice = nil
        while choice != 'back'
            print "What would you like to do?  ".colorize(:light_green)
                choice = gets.strip.downcase
            case choice
            when 'menu'
                ship_options
            when '1'
                ships_by_name
            when '2'
                ships_by_man
            when '3'
                sort_list("price")
            when '4'
                ships_by_attr
            else
                puts "Invalid input.  Please choose an option from the menu.  Type 'menu' to see the menu again, or type 'back' to return to the main menu.".colorize(:light_magenta) unless choice == 'back'
            end
        end
    end
    
    def ship_options
        puts "  ---  Ship Information  ---  ".colorize(:light_yellow)
        puts <<-SHIPMENU
        1. List all ships in alphabetical order
        2. List ships by a particular manufacturer
        3. Sort ships by price
        4. Sort ships by another attribute
        SHIPMENU
    end
    
    def display_ship(input)
        return unless Ship.find_by_name(input)
        ship = Ship.find_by_name(input)
        puts "     #{ship.name.colorize(:light_red)}"
        puts "#{ship.description.colorize(:light_cyan)}"
        puts <<-SHIP
        Manufactured by:  #{ship.manufacturer.name.colorize(:light_cyan)}
        Base Price:  #{ship.price.colorize(:light_cyan)}
        Hull Mass:  #{ship.mass.colorize(:light_cyan)}
        Base Speed:  #{ship.speed.colorize(:light_cyan)}
        Armor:  #{ship.armor.colorize(:light_cyan)}
        Shields:  #{ship.shield.colorize(:light_cyan)}
        SHIP
    end

    def display_man(input)
        return unless Manufacturer.find_by_name(input)
        man = Manufacturer.find_by_name(input)
        puts man.name.colorize(:light_red)
        man.ships.each {|s| puts s.colorize(:light_cyan)}
    end

    def ships_by_attr
        puts <<-LIST
        1. Armor
        2. Shields
        3. Base Speed
        4. Hull Mass
        LIST
        print "Please choose an attribute.  ".colorize(:light_green)
        choice = gets.strip.downcase
        case choice
        when "1", "armor"
            sort_list("armor")
        when "2", "shields"
            sort_list("shield")
        when "3", "base speed", "speed"
            sort_list("speed")
        when "4", "hull mass", "mass"
            sort_list("mass")
        else
            puts "Invalid input.".colorize(:light_magenta)
        end
    end

    def ships_by_name
        list = Ship.all.sort {|a, b| a.name <=> b.name}
        print_list(list)
        select_ship(list)
    end

    def sort_list(attr)
        sorted = Ship.all.sort {|a, b| a.instance_variable_get(("@" + attr).to_sym).gsub(",", "").gsub(" m/s", "").to_i <=> b.instance_variable_get(("@" + attr).to_sym).gsub(",", "").gsub(" m/s", "").to_i}
        print_list(sorted)
        select_ship(sorted)
    end

    def ships_by_man
        list = Manufacturer.all.sort {|a, b| a.name <=> b.name}
        print_list(list)
        print "Please choose a manufacturer.  ".colorize(:light_green)
        choice = gets.strip.downcase
        if choice.to_i == 0
            display_man(choice)
        else
            display_man(list[choice.to_i - 1].name)
        end
    end

    def select_ship(list)
        print "Please choose a ship to learn more about.  ".colorize(:light_green)
        choice = gets.strip.downcase
        if choice.to_i == 0
            display_ship(choice)
        else
            display_ship(list[choice.to_i - 1].name)
        end
    end

    def print_list(list)
        list.each_with_index {|s, i| puts "#{i + 1}. #{s.name}"}
    end
end