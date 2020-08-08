class Scraper
    def get_ships
        doc = Nokogiri::HTML(open("http://www.elitedangerous.com/ships"))
        doc.css("div.c-ships-listing__cards-item").each do |s|
            ship = Ship.create(s.css("h3").text)
            ship.manufacturer = s.css("p").text
            add_description(ship, s)
            data = s.css("dl dd").collect {|d| d.text}
            add_stats(ship, data)
        end
    end

    def add_description(ship, s)
        url = s.xpath('./a/@href').text
        desc = Nokogiri::HTML(open("http://www.elitedangerous.com" + url))
        ship.description = desc.css("div.c-ship-masthead__description").text
    end

    def add_stats(ship, data)
        ship.armor = data[0]
        ship.shield = data[1]
        ship.speed = data[2]
        ship.mass = data[3]
        ship.price = data[4]
    end

    def get_engineers
        doc = Nokogiri::HTML(open("http://www.inara.cz/galaxy-engineers"))
        doc.css("div.engineerslistportraitcontainer").each do |e|
            engi = Engineer.create(e.css("h4").text)
            engi.sys = e.css("span.uppercase").text
            engi.base = e.css("span").first.text.gsub(" | ", "")
            add_specialties(engi, e)
        end
    end

    def add_specialties(engi, e)
        mods = e.css("span.small").collect {|v| v.text}
        grades = e.css("span.smaller").collect {|v| v.text}
        mods.each do |m|
            c = Component.find_or_create_by_name(m)
            c.add_engineer(engi)
        end
        engi.specs = grades.zip(mods).collect {|s| s.join(" ")}
    end
end
puts "Scraping data..."
Scraper.new.get_ships
puts "Ships loaded."
Scraper.new.get_engineers
puts "Engineers loaded."