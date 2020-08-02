class OhSeven::CLI
    include ShipMethods
    def call
        puts "  ---  o7, CMDR. Welcome to the Elite Dangerous Quick Reference Helper.  ---  ".colorize(:light_red)
        option_list
        main_menu
    end

    def option_list
        puts <<-MENU
        1. Ship Information
        2. Engineer Information
        3. Station Finder
        4. Scoopable Star Finder
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
                engi_info
            when "3","station finder"
                find_station
            when "4","scoopable star finder","star finder"
                find_star
            when "menu"
                option_list
            when "exit"
                goodbye_message
            else
                puts "Invalid input. Please choose an option from the menu. Type 'menu' to see the list again, or 'exit' to end."
            end
        end
    end


    def engi_info
        puts "engi info"
    end

    def find_station
        puts "station found"
    end

    def find_star
        puts "star found"
    end

    def goodbye_message
        puts "  ---  Thank you for visiting. Fly safe, CMDR.  ---  ".colorize(:light_red)
    end
end