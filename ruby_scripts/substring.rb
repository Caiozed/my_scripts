def substrings (word, dictionary)
	words = Hash.new(0) 
	word.split(/\W+/).each{|x|
		dictionary.each{|w|
			words[w.to_sym] += 1 if x.downcase.match(w.downcase) 
		}
	}
	words.each{|k, v| puts "#{k.to_s}: #{v}"}
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Below, down", dictionary)