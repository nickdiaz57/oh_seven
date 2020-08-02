class Manufacturer
    attr_accessor :name, :ships
    extend Concerns

    @@all = []

    def initialize(name)
        @name = name
        @ships = []
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def ships
        @ships.collect {|s| s.name} .uniq
    end

    def add_ship(ship)
        ship.manufacturer = self if ship.manufacturer == nil
        @ships << ship unless @ships.find {|s| s == ship}
    end
end