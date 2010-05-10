#!/usr/bin/ruby

class Subversion
	
	def batch_add
		`svn st`.split(/\n/).each do |line|
			next unless line =~ /\?.+/
			fname = line.gsub(/\?\s+(.*)/) {$1}.gsub(' ', '\ ')
			`svn add #{fname}`
		end
	end

end

Subversion.new.batch_add
