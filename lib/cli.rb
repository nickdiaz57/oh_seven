class OhSeven::CLI
    include ShipMethods, EngiMethods
    def call
        puts "  ---  o7, CMDR. Welcome to the Elite Dangerous Quick Reference Helper.  ---  ".colorize(:light_red)
        option_list
        main_menu
        goodbye_message
    end

    def option_list
        puts "  ---  Main Menu  ---  ".colorize(:light_yellow)
        puts <<-MENU
        1. Ship Information
        2. Engineer Information
        MENU
    end

    def main_menu
        choice = nil
        while choice != 'exit'
            puts "Please select an option from the menu, or type 'exit' to end the application."
            choice = gets.strip.downcase
            case choice
            when "1","ship information","ship info"
                ship_options
                ship_info
            when "2","engineer information","engineer info"
                engi_options
                engi_info
            when "menu"
                option_list
            else
                puts "Invalid input. Please choose an option from the menu. Type 'menu' to see the list again, or 'exit' to end." unless choice == 'exit'
            end
        end
    end

    def goodbye_message
        puts "  ---  Thank you for visiting. Fly safe, CMDR.  ---  ".colorize(:light_red)
    end
end