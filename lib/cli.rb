class OhSeven::CLI
    include ShipMethods, EngiMethods
    def call
        puts "  ---  o7, CMDR. Welcome to the Elite Dangerous Quick Reference Helper.  ---  ".colorize(:light_red)
        main_menu
        goodbye_message
    end

    def option_list
        puts "\n  ---  Main Menu  ---  ".colorize(:light_yellow)
        puts <<-MENU
        1. Ship Information
        2. Engineer Information
        
        MENU
    end

    def main_menu
        choice = nil
        while choice != 'exit'
            option_list
            print "Please select an option from the menu, or type 'exit' to end the application.  ".colorize(:light_green)
            choice = gets.strip.downcase
            case choice
            when "1","ship information","ship info"
                ship_info
            when "2","engineer information","engineer info"
                engi_info
            else
                puts "Invalid input. Please choose an option from the menu, or type 'exit' to end.".colorize(:light_magenta) unless choice == 'exit'
            end
        end
    end

    def goodbye_message
        puts "  ---  Thank you for visiting. Fly safe, CMDR.  ---  ".colorize(:light_red)
    end
end