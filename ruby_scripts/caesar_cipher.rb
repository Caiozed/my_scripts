def ceasar_cypher(text_to_encode, num)
	letters = ("a".."z").to_a
	text_to_encode.chars.map{|c| 
		if c.downcase == 'z'
			c = ('a'.ord + num - 1).chr
		else
			letters.include?(c.downcase) ? (c.ord + num).chr : c
		end
	}.join
end

puts ceasar_cypher("Ceasar is deadz", 2)
