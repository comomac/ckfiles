require 'zlib'

# check if directed is restricted
def Dir.restricted?( dir, excludes=[] )
	rdirs = [
		/\.Trash/, /\.Trashes/, /\.fseventsd/, /\.Spotlight-V100/, /\.DocumentRevisions-V100/,
		/\.git/,
		/\/\./,
		/\.\$EXTEND/,
		/_SYNCAPP/,
		/Corrupted/,
		/System Volume Information/, /RECYCLER/,
		/backup/i,
		/\/Library\//,
		/\.sparsebundle/,
		/\.tmpdir/, /\.tmp7z/,
		/\.AppleDouble/
	]

	for word in rdirs - excludes
	    return true if dir.match( word )
    end
    return false
end

def load_cksum_list( sumtype, file )
	# returns { file1=>sum, file2=>sum, file3=>sum ... fileN=>sum }
	
	if sumtype == 'sfv'
		file_ext = 'sfv'
	elsif sumtype == 'md5'
		file_ext = 'md5'
	else
		raise 'not supported cksum type'
	end
	
	sfs = File.new( file ).readlines
	sfs.collect! { |y| y.chomp }
	begin
		sfs = sfs.collect { |y| y.gsub(/\\/,'/') }
	rescue => errmsg
		puts "ERROR: #{errmsg}  FILE:  #{file}"
	end
	sfs.flatten!
	sfs.compact!
	sfs.delete_if { |y| y == '' }
	sfs.delete_if { |y| y[0..0] == '#' }
	sfs.delete_if { |y| y[0..0] == ';' }
	sfs.delete_if { |y| y[0..4] == 'MD5 (' } #this format is a pain so drop
	
	n = {}	
	if sumtype == 'sfv'
		for s in sfs
			n[s[0..-10]] = s[-8..-1]
		end
	elsif sumtype == 'md5'
		for s in sfs
			n[s[34..-1]] = s[0..31]
		end
	end
	n.each { |f,sum| puts "#{sum} #{f}" } if $debug

	if n.length > 0
		n
	else
		{}
	end	
end

# return crc32 sum for file
def File.crc32(f)
	ptr_f = File.new(f,'rb')
	
	r = 0
	while ! ptr_f.eof?
		r = Zlib.crc32( ptr_f.read(1024**2) , r )
	end
	ptr_f.close
	
	r.to_s(16).rjust(8).gsub(' ','0').downcase
end

# return md5sum for file
def File.md5(f)
	Digest::MD5.file(f).hexdigest
end

class String
	# translate length of time to integer format
	# e.g. 3m -> 180 (seconds)
	def timelength_to_i
		units = {
			'm'=>60,
			'h'=>60*60,
			'd'=>60*60*24,
			'w'=>60*60*24*7,
			'mo'=>60*60*24*30,
			'y'=>60*60*24*365
		}
		
		u = 1
		n = self.to_f
		for unit, num in units
			if self =~ /#{unit}$/i
				u = num
				break
			end
		end
		
		return (u*n).to_i
	end

	def escape_glob
		# escape any character that will affect Dir.glob
		self.gsub(/([\[\]\{\}\*\?\\])/, '\\\\\1')
	end

	def ascii
		# return only ascii characters in array
		regex = /[A-Za-z0-9\ \%\;\'\@\~\-\(\)\[\]\&\_\{\}\+\.\/\!\,\#]/
		self.scan(regex)
	end
	
	def not_ascii
		# return only none ascii characters in array
		regex = /[^A-Za-z0-9\ \%\;\'\@\~\-\(\)\[\]\&\_\{\}\+\.\/\!\,\#]/
		self.scan(regex)
	end
end
