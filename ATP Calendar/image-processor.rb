#!/usr/bin/ruby


class Rename
	
	def do
		Dir.foreach('.') do |dir|
			unless dir =~ /\./ 
				Dir.chdir(dir)

				index = -1;				

				Dir.foreach('.') do |file|
					if file =~ /jpg|png/ 
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

				Dir.chdir('..')
			end
		end
	end	

end

Rename.new.do
