class StringCalculator
	def self.add(input)
		sum = 0
		return 0 if input.empty? == 0
		input.split(",").each{|x| sum += x.to_i}
		sum
	end
end
