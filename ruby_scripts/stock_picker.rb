def stock_picker(prices) 
	"#{prices.index(prices.min)}, #{prices.index(prices.max)}"
end

puts stock_picker([17, 9, 5, 50, 10])
