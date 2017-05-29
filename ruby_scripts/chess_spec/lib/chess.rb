require './move_pawns'

class Chess 
	attr_accessor :board 

	def initialize
		@board = Hash.new { |hash, key| hash[key] = []}
		@letters = ("A".."H").to_a
		@letters.reverse!
		@whites = ["|WT|","|WH|","|WB|","|WQ|","|WK|","|WB|","|WH|","|WT|"]
		@blacks = ["|BT|","|BH|","|BB|","|BQ|","|BK|","|BB|","|BH|","|BT|"]
		@current_player="W" 
	end

	def check_input(input, check_pawn = false)
		if input.empty?
			puts "Please choose a position!"
			if check_pawn
				choose_pawn
			else
				move
			end	
		elsif !(input.any?{|i| @letters.include?(i)} && input[0].between?(1,8))
			puts "Invalid position!"
			if check_pawn
				choose_pawn
			else
				move
			end	
		end
		input
	end

	def translate_letters(input)
		case input[1]
		when "H"
			input[1] = 1
		when "G"
			input[1] = 2	
		when "F"
			input[1] = 3	
		when "E"
			input[1] = 4	
		when "D"
			input[1] = 5	
		when "C"
			input[1] = 6	
		when "B"
			input[1] = 7	
		when "A"
			input[1] = 8	
		end
		input
	end

	def check_pawn_position(input, color="B") 
		@pawn = @board[input[0]][input[1]] 
		@pawn_pos = input
		if @board[input[0]][input[1]][1]  == color
			move
		else
			puts "No pawn of yours in this position"
			choose_pawn
		end
	end

	def identify_pawn(pawn, current, move_to, board)
		case pawn
		when "|BP|", "|WP|"
			board = MovePawns.move_pawn(move_to, current, board, @current_player)
		when "|BT|", "|WT|"
			board = MovePawns.move_tower(move_to, current, board, @current_player)
		when "|BH|", "|WH|"
			board = MovePawns.move_horse(move_to, current, board, @current_player)
		when "|BB|", "|WB|"
			board = MovePawns.move_bishop(move_to, current, board, @current_player)
		when "|BQ|", "|WQ|"
			board = MovePawns.move_queen(move_to, current, board, @current_player)
		when "|BK|", "|WK|"
			board = MovePawns.move_king(move_to, current, board, @current_player)
		end
		board
	end

	def choose_position
		pos = gets.chomp
		pos.upcase!
		pos_arr = pos.split(/\W+/)
		pos_arr[1] = pos_arr[1].to_i
		pos_arr.reverse!
		pos_arr = pos_arr[0..1]
		pos_arr
	end

	def toggle_player
		@current_player == "B" ? @current_player = "W" : @current_player = "B" 
		if @current_player == "W"
			puts "**********White move!**********" 
		else
			puts "**********Black move!**********" 
		end
	end

	def setup
		for i in 1..8 
			for j in 1..8
				@board[i][j] = "|  |"
			end
		end

		for i in 1..8 
			@board[1][i] = @whites[i-1]
		end

		for i in 1..8 
			@board[2][i] = "|WP|"
		end

		for i in 1..8 
			@board[8][i] = @blacks[i-1]
		end

		for i in 1..8 
			@board[7][i] = "|BP|"
		end
		toggle_player
		draw
	end

	def draw
		print "* "
		@letters.each{|letter| print " #{letter}  "}
		puts ""
		@board.each{|h, v| puts "#{h} #{v.join}"}
		choose_pawn
	end

	def choose_pawn
		puts "Choose the pawn position:"
		pos = translate_letters(check_input(choose_position, true))
		check_pawn_position(pos, @current_player)
	end

	def move
		puts "Choose a position to move:"
		pos = translate_letters(check_input(choose_position, false))
		game_over if check_winner(pos)
		@board = identify_pawn(@pawn, @pawn_pos, pos, @board)
		toggle_player
		draw
	end

	def check_winner(input)
		if @board[input[0]][input[1]] == "|BK|"
			puts "*************White wins!*************"
			return true
		elsif @board[input[0]][input[1]] == "|WK|"
			puts "*************Black wins!*************"
			return true
		end
		return false
	end

	def game_over
		puts "Play again? (y/n)"
		answer = gets.chomp.downcase
		if answer == "y"
			setup
		else
			abort("Thank you for playing!")
		end
	end
end

game = Chess.new
game.setup