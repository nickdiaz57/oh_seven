module ShipMethods
    
    def ship_info
        ship_options
        choice = nil
        while choice != 'back'
            puts "What would you like to do?"
                choice = gets.strip.downcase
            case choice
            when 'menu'
                ship_options
            when '1'
                ships_by_alph
            when '2'
                ships_by_man
            when '3'
                ships_by_price
            when '4'
                ships_by_attr
            else
                puts "Invalid input.  Please choose an option from the menu.  Type 'menu' to see the menu again, or type 'back' to return to the main menu." unless choice == 'back'
            end
        end
    end
    
    def display_ship(input)
        return unless Ship.find_by_name(input)
        ship = Ship.find_by_name(input)
        puts "     #{ship.name.colorize(:light_red)}"
        puts "     #{ship.description.colorize(:light_cyan)}"
        puts <<-SHIP
        Manufactured by:  #{ship.manufacturer.name.colorize(:light_cyan)}
        Base Price:  #{ship.price.colorize(:light_cyan)}
        Hull Mass:  #{ship.mass.colorize(:light_cyan)}
        Base Speed:  #{ship.speed.colorize(:light_cyan)}
        Armor:  #{ship.armor.colorize(:light_cyan)}
        Shields:  #{ship.shield.colorize(:light_cyan)}
        SHIP
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

    def ships_by_alph
        list = Ship.all.sort {|a, b| a.name <=> b.name}
        print_list(list)
        select_ship(list)
    end

    def ships_by_attr
        puts <<-LIST
        1. Armor
        2. Shields
        3. Base Speed
        4. Hull Mass
        LIST
        print "Please choose an attribute."
        choice = gets.strip.downcase
        case choice
        when "1", "armor"
            arm
        when "2", "shields"
            shld
        when "3", "base speed", "speed"
            spd
        when "4", "hull mass", "mass"
            hull
        end
    end

    def arm
        armor_list = Ship.all.sort {|a, b| a.armor.to_i <=> b.armor.to_i}
        print_list(armor_list)
        select_ship(armor_list)
    end

    def shld
        shield_list = Ship.all.sort {|a, b| a.shield.to_i <=> b.shield.to_i}
        print_list(shield_list)
        select_ship(shield_list)
    end

    def spd
        speed_list = Ship.all.sort {|a, b| a.speed.gsub(" m/s", "").to_i <=> b.speed.gsub(" m/s", "").to_i}
        print_list(speed_list)
        select_ship(speed_list)
    end

    def hull
        hull_list = Ship.all.sort {|a, b| a.mass.to_i <=> b.mass.to_i}
        print_list(hull_list)
        select_ship(hull_list)
    end

    def ships_by_man
        Manufacturer.all.each_with_index {|m, i| puts "#{i + 1}. #{m.name}"}
        puts "Please choose a manufacturer."
        choice = gets.strip.downcase
        if choice.to_i == 0
            man = Manufacturer.find_by_name(choice)
            puts man.name.colorize(:light_red)
            man.ships.each {|s| puts s.colorize(:light_cyan)}
        else
            man = Manufacturer.all[choice.to_i - 1]
            puts man.name.colorize(:light_red)
            man.ships.each {|s| puts s.colorize(:light_cyan)}
        end
    end

    def ships_by_price
        list = Ship.all.sort {|a, b| a.price.gsub("," , "").to_i <=> b.price.gsub("," , "").to_i}
        print_list(list)
        select_ship(list)
    end

    def select_ship(list)
        print "Please choose a ship to learn more about."
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