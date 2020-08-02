module Concerns

    def create(name)
        n = self.new(name)
        n.save
        n
    end

    def find_by_name(name)
        all.find {|i| i.name.downcase == name.downcase}
    end

    def find_or_create_by_name(name)
        if find_by_name(name)
            find_by_name(name)
        else
            create(name)
        end
    end
end