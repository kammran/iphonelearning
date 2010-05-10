#!/usr/bin/ruby

require 'rubygems'
require 'mini_magick'

class Rename
	
	include MiniMagick

	@template_plist

	def initialize
		@template_plist = IO.readlines('template.plist').join
	end

	def do
		Dir.foreach('.') do |dir|
			unless dir =~ /\./ 
				Dir.chdir(dir)
				Dir.foreach('.') do |file|
					rename(dir, file)
				end
				Dir.foreach('.') do |file|
					resize(file)
				end
				generate_plist(dir)
				Dir.chdir('..')
			end
		end
	end	
	
	def supported?(file)
		#yield if file =~ /jpg|png/ 
		yield if file =~ /png/
	end

	def rename(dir, file)
		index = -1;				
		supported?(file) do 
			unless file.include? dir
				index = index.next
				type = file.sub(/.+\.(.+)/) {$1}
				newFile = "#{dir}-#{index}.#{type}"
				while File.exists? newFile
					index = index.next
					newFile = "#{dir}-#{index}.#{type}"
				end
				puts "Renaming #{file} to #{newFile}"
				File.rename(file, newFile)
			end
		end
	end

	def resize(file)
		supported?(file) do
			image = Image.new(file)
			original_width = image[:width]
			original_height = image[:height]
			new_width = 160 
			if (-5..5).include?(original_width - new_width) 
				#puts "Skipped #{file}"
				next
			end
			new_height = 200 * original_height / original_width 
			old_size = "#{original_width}x#{original_height}"
			new_size = "#{new_width}x#{new_height}"
			puts "Resizing #{file} from #{old_size} to #{new_size}"
			image.resize new_size 
		end
	end
	
	def generate_plist(dir)
		images = Dir.entries('.').select {|file| file =~ /png|jpg/}
		image_count = images.size
		image_type = images.empty?? '' : images.first.sub(/.*\.(.+)/) { $1 }
		plist = @template_plist.gsub('${ImageCount}', image_count.to_s).gsub('${ImageType}', image_type)
		File.open("#{dir}.plist", 'w') {|f| f.write(plist)}
	end

end

Rename.new.do if __FILE__ == $0

