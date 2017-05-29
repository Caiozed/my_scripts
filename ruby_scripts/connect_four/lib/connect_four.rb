class ConnectFour
	attr_accessor :res, :board, :pos, :pos_array
	def initialize
		@player = "|Y|"
		@pos = "" 
		@pos_array = []
		@x = 0
		@y = 0
		@res = 0
		@board = Hash.new { |hash, key| hash[key] = []}
	end

	def setup
		print "Choose the size of the board:\n"
		@res = gets.chomp
		@res = @res.to_i
		if @res < 3 
			$stderr.puts "choose a valid board size!"
			setup
		end
		create_board
	end

	def create_board
		for i in 0..@res  
			for j in 0..@res 
				@board[i][j] = "| |"
			end	
		end
		draw 
	end

	def draw
		print "* "
		for i in 0..@res
			print " #{i} "
		end
		print "\n"
		@board.each{|k, v| puts "#{k} #{v.join}"}
		turn
	end

	def turn
		print "Choose a position: (row, collum)\n"
		@pos = gets.chomp 
		@pos_array = @pos.split(/\D+/)
		@pos_array = @pos_array[0..1]
		turn if !check_input(@pos_array[0], @pos_array[1], switch_player(@player))
		check_winner("|R|")
		check_winner("|Y|")
		draw if !game_over?
	end

	def check_input (x = nil, y = nil, player = "| |")
		x, y = x.to_i, y.to_i if !x.nil? || !y.nil?
		if x.nil? || y.nil?
			warn "i need positions!"
		elsif !x.between?(0, @res) && !y.between?(0, @res)
			warn "not a valid position!"
		elsif @board[x][y] != "| |"
			warn "position already filled!"	
		else
			@board[x][y] = player
			puts "position inserted!"
			return true
		end
		return false
	end

	def switch_player(player)
		player == "|R|" ? player = "|Y|" : player = "|R|" 
		@player = player
		return player
	end

	def check_winner(player = "") 
		count = 0
		for i in 0..@res
			for j in 0..@res
				if @board[i][j] == player
					count +=1
					if count >= 4
						winner = ""
						player == "|R|" ? winner = "Red " : winner = "Yellow "
						puts "#{winner} wins"
						return true
					end
				else
					count = 0
				end
			end
		end

		for i in 0..@res
			if @board[i][i] == player
				count +=1
				if count >= 4
					winner = ""
					player == "|R|" ? winner = "Red " : winner = "Yellow "
					puts "#{winner} wins"
					return true
				end
			else
				count = 0
			end
		end

		for i in 0..@res
			if @board[i][@res-i] == player
				count +=1
				if count >= 4
					winner = ""
					player == "|R|" ? winner = "Red" : winner = "Yellow"
					puts "#{winner} wins"
					return true
				end
			else

				count = 0
			end
		end
		return false
	end

	def game_over?
		game_over = false
		for i in 0..@res
			for j in 0..@res
				if @board[i][j] != "| |"
					game_over = true
				else
				 	game_over = false
				end  
			end
		end
		puts "Game over!" if game_over
		return game_over
	end	
end

game = ConnectFour.new
game.setup



