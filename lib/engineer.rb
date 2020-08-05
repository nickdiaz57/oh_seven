class Engineer
    attr_accessor :name, :sys, :base, :components, :specs
    extend Concerns

    @@all = []

    def initialize(name)
        @name = name
        @components = []
    end
    
    def self.all
        @@all
    end

    def save
        @@all << self
    end
end