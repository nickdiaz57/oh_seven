module ShipMethods
    
    def ship_info
        choice = nil
        while choice != 'exit' || 'back'
            puts "What would you like to do?"
            choice = gets.strip.downcase
            case choice
            when 'exit'
                goodbye_message
            when 'back'
                option_list
                main_menu
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
                puts "Invalid input.  Please choose an option from the menu.  Type 'back' to return to the main menu, or 'exit' to end."
            end
        end
    end
    
    def display_ship(input)
        ship = Ship.find_by_name(input)
        puts "     #{ship.name.colorize(:light_red)}"
        puts "     #{ship.description.colorize(:light_cyan)}"
        puts <<-SHIP
        Manufactured by:  #{ship.manufacturer.name.colorize(:light_cyan)}
        Base Price:  #{ship.price.colorize(:light_cyan)}
        Hull Mass:  #{ship.mass.colorize(:light_cyan)}
        Top Speed:  #{ship.speed.colorize(:light_cyan)}
        Armor:  #{ship.armor.colorize(:light_cyan)}
        Shields:  #{ship.shield.colorize(:light_cyan)}
        SHIP
    end

    def ship_options
        puts <<-SHIPMENU
        1. List all ships in alphabetical order
        2. List ships by a particular manufacturer
        3. Sort ships by price
        4. Sort ships by another attribute
        SHIPMENU
    end

    def ships_by_alph
        list = Ship.all.sort {|a, b| a.name <=> b.name}
        list.each_with_index {|s, i| puts "#{i + 1}. #{s.name}"}
        puts "Please choose a ship to learn more about."
        choice = gets.strip.downcase
        if choice.to_i == 0
            display_ship(choice)
        else
            display_ship(list[choice.to_i - 1].name)
        end
    end

    def ships_by_attr
        puts "No"
    end

    def ships_by_man
        puts "Nah"
    end

    def ships_by_price
        puts "Piss off, mate"
    end
end