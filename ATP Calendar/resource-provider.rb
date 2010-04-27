#!/usr/bin/ruby

require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'builder' 

class ResourceProvider
	
	@@url = 'http://www.atpworldtour.com/Tournaments/Event-Calendar.aspx' 	

	def generate
		File.open('data.xml', 'w') {|f| f.write xml}
	end

	def xml
		xml = '' 
		builder_doc = Builder::XmlMarkup.new(:target => xml, :indent => 2) 
		builder_doc.instruct!

		puts "Loading #{@@url}"
		src_doc = open(@@url) { |f| Hpricot(f) }
		puts "Successfully loaded #{@@url}"
		elements = src_doc.search("//div[@class='calendarTable']")

		builder_doc.root do |builder_root|		
			elements.each do |monthElement|
				month = monthElement.at('h4').inner_text	
				builder_root.month do |builder_month|
					builder_month.name(month)
					monthElement.search("//tr[@class='calendarFilterItem']").each do |matchRow|
						builder_month.match do |builder_match|
							columns = matchRow.search('td')				
							columns.size.times do |index|
								td = columns[index]
								case index
								when 0  
									img_element = td.at('img')
									img_src = img_element.nil? ? nil : img_element.attributes['src']
									builder_match.category(category_of(img_src))
								when 1 
									date = td.inner_text.strip
									builder_match.date(date)
								when 2
									array = td.search('/strong')
									name = array[0].inner_text.strip
									cityAndCountry = array[1].inner_text.strip
									array = cityAndCountry.split(',').map {|e| e.strip}
									city = array[0]
									country = array[1]
									builder_match.name(name)
									builder_match.city(city)
									builder_match.country(country)
								when 3
									surface = td.inner_html.gsub('<br />', ' ').strip
									builder_match.surface(surface)
								when 4
									money = td.inner_text.strip
									money =~ /(.*)\((.*)\)/m
									prize = strip_safely($1) 
									total = strip_safely($2)
									builder_match.prize(prize)
									builder_match.total(total)
								when 5
									draw = strip_safely(td.inner_text)
									draw =~ /SGL.*?(\d+).*DBL.*?(\d+)/m
									sgl = strip_safely($1) 
									dbl = strip_safely($2)
									builder_match.sgl(sgl)
									builder_match.dbl(dbl)
								when 6 
									ticketInfo = td.inner_html.strip
									emailHref = td.at('a')
									email = '' if emailHref.nil?
									email = emailHref.attributes['href'].gsub(/[mailto:]+(.*)/) {|m| $1} if !emailHref.nil?
									tel = ticketInfo.gsub(/<a.*<\/a>/, '').gsub(/<br \/>/, '')
									builder_match.email(email)
									builder_match.tel(tel)
								when 7
									winners = td.inner_text.strip
									winners =~ /.*Singles.*:(.+)Doubles.*:(.+)/m
									single_winner = strip_safely($1) 
									double_winners = strip_safely($2)
									builder_match.single_winner(single_winner)
									builder_match.double_winners(double_winners)	
								end
							end
						end					
					end
				end
			end
		end
		
		xml
	end

	def strip_safely(obj)
		obj.nil? ? '' : obj.strip	
	end
	
	def category_of(img_src)
		return "DavisCup" if img_src.nil?		
		h = {
			'810218DC73784BEEA6EF0978B2842A69' => 'ATP250',
			'1DB04CA8505648B7B511FA1E37F1E3BA' => 'ATP500',
			'F5219431817E4ED3B773BF9B006A9ACF' => 'ATP1000',
			'47F12472FD254B08B57755E5B7565E5D' => 'ATP_FINALS',
			'14B53566CC54409F99A8423521E30D18' => 'GrandSlam'
		}	
		img_name = Regexp.new("/~/media/(.+)\.ashx.*").match(img_src)[1]
		h[img_name]
	end

end

ResourceProvider.new.generate