#!/usr/bin/env ruby
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    def get_page
        #doc = Nokogiri::HTML(open("http://edsy.org"))
        doc = Nokogiri::HTML(open("http://www.elitedangerous.com/ships"))
        doc.css("div.c-ships-listing__cards-item").each do |s|
            ship = Ship.create(s.css("h3").text)
            ship.manufacturer = s.css("p").text
            url = s.xpath('./a/@href').text
            desc = Nokogiri::HTML(open("http://www.elitedangerous.com" + url))
            ship.description = desc.css("div.c-ship-masthead__description").text
            data = []
            s.css("dl dd").each {|d| data << d.text}
            ship.armor = data[0]
            ship.shield = data[1]
            ship.speed = data[2]
            ship.mass = data[3]
            ship.price = data[4]
        end
        binding.pry
    end

    #def add_stats(ship)
        
    #end
end

Scraper.new.get_page