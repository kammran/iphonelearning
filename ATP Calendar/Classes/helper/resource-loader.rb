#!/usr/bin/ruby

require 'rubygems'
require 'open-uri'
require 'hpricot'



class ResourceLoader

	def load
		doc = open("Event-Calendar.aspx") { |f| Hpricot(f) }
		elements = doc.search("//div[@class='calendarTable']")
		elements.each do |monthElement|
			month = monthElement.at('h4').inner_text	
			puts month
			monthElement.search("//tr[@class='calendarFilterItem']").each do |matchRow|
				columns = matchRow.search('td')				
				columns.size.times do |index|
					td = columns[index]
					case index
					when 0  
						imgElement = td.at('img')
						imgSrc = imgElement.nil? ? nil : imgElement.attributes['src']
						puts imgSrc
					when 1 
						date = td.inner_text.strip
						puts date
					when 2
						array = td.search('/strong')
						name = array[0].inner_text.strip
						puts name
						cityAndCountry = array[1].inner_text.strip
						array = cityAndCountry.split(',').map {|e| e.strip}
						city = array[0]
						country = array[1]
						puts city
						puts country
					when 3
						surface = td.inner_html.gsub('<br />', ' ').strip
						puts surface
					when 4
						money = td.inner_text.strip
						money =~ /(.*)\((.*)\)/m
						prize = stripSafely($1) 
						total = stripSafely($2)
						puts prize
						puts total
					end
				end

				puts '------------'
			end
		end
	end

	def stripSafely(obj)
		obj.nil? ? '' : obj.strip	
	end
end


ResourceLoader.new.load
