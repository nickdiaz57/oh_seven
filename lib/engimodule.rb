module EngiMethods
    
    def engi_info
        engi_options
        choice = nil
        while choice != 'back'
            print "What would you like to do?  "
                choice = gets.strip.downcase
            case choice
            when 'menu'
                engi_options
            when '1'
               engi_list
            when '2'
                engi_by_specs
            else
                puts "Invalid input.  Please choose an option from the menu.  Type 'menu' to see the menu again, or type 'back' to return to the main menu." unless choice == 'back'
            end
        end
    end

    def display_engi(input)
        return unless Engineer.find_by_name(input)
        engi = Engineer.find_by_name(input)
        puts "     #{engi.name.colorize(:light_red)}"
        puts "Based out of #{engi.base} in the #{engi.sys} system".colorize(:light_cyan)
        engi.specs.each {|s| puts s.colorize(:light_cyan)}
    end

    def display_component(input)
        return unless Component.find_by_name(input)
        comp = Component.find_by_name(input)
        puts comp.name.colorize(:light_red)
        comp.engineers.each {|e| puts e.name.colorize(:light_cyan)}
    end

    def engi_list
        list = Engineer.all.sort {|a, b| a.name <=> b.name}
        print_list(list)
        select_engi(list)
    end

    def engi_by_specs
        print_list(Component.all)
        print "Please choose a component.  "
        choice = gets.strip.downcase
        if choice.to_i == 0
            display_component(choice)
        else
            display_component(Component.all[choice.to_i - 1].name)
        end
    end

    def print_list(list)
        list.each_with_index {|s, i| puts "#{i + 1}. #{s.name}"}
    end

    def select_engi(list)
        print "Please choose an engineer to learn more about.  "
        choice = gets.strip.downcase
        if choice.to_i == 0
            display_engi(choice)
        else
            display_engi(list[choice.to_i - 1].name)
        end
    end

    def engi_options
        puts "  ---  Engineer Options  ---  ".colorize(:light_yellow)
        puts <<-ENGIMENU
        1. List all engineers
        2. Search for engineers specializing in a particular component
        ENGIMENU
    end
end