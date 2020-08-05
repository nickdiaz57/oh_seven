class Component
    attr_accessor :name, :engineers
    extend Concerns

    @@all = []

    def initialize(name)
        @name = name
        @engineers = []
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def add_engineer(engi)
        engi.components << self unless engi.components.include?(self)
        @engineers << engi unless @engineers.find {|e| e == engi}
    end
end