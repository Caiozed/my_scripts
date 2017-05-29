
def fibs(num = 0)
	return 0 if num == 0
	return 1 if num == 1
	return fibs(num-1)+fibs(num-2)
end

11.times do |i|
  puts "f(#{i}) = #{fibs(i)}"
end