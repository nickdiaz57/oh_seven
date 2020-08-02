class Ship
    attr_accessor :name, :description, :price, :size, :speed, :armor, :shield, :mass
    attr_reader :manufacturer
    extend Concerns

    @@all = []

    def initialize(name)
        @name = name
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def manufacturer=(manufacturer)
        man = Manufacturer.find_or_create_by_name(manufacturer)
        @manufacturer = man
        man.add_ship(self)
    end
end