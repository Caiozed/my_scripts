class Player
	attr_reader :name, :player_id, :number_of_players
	@@number_of_players = 1
	def initialize
		setup
	end

	def setup
		@player_id = @@number_of_players
		if @@number_of_players <= 2 
			puts "Player #{@player_id}, Insert you player name:"
			@name = gets.chomp
			@@number_of_players += 1
		end
	end
end

class Game
	attr_reader :board_size
	attr_accessor :on_game, :turn_swap

	def initialize
		create
	end

	def create
		@min_size = 2
		@max_size = 4
		@board_size = 0
		@on_game = true
		@turn_swap = 1                                           
		while !@board_size.between?(@min_size, @max_size)
			puts "Define the size of the game board between #{@min_size} and #{@max_size} :"
			@board_size = gets.chomp.to_i
			puts "Invalid number" if !@board_size.between?(@min_size, @max_size)
		end
		draw
	end

	def draw 
		@board_positions = Hash.new{|h, k| h[k] = []}
		for i in 0..@board_size 
			for j in 0..@board_size 
				@board_positions[i][j] = "| |"
			end
		end
		update
	end

	def update
		puts "Current board:"
		print " * "
		for i in 0..@board_size
			print " #{i} "
		end
		puts ""
		@board_positions.each{|k, v| puts " #{k} #{v.join}"}
		check_winner
	end

	def add(player_id)
		@x=-1
		@y=-1
		while (!@x.between?(0, @board_size) && !@y.between?(0, @board_size)) 
			puts "Player #{player_id}, please add yor move!"
			puts "What position do you wish to place? "
			@positions =  gets.chomp.split(/\D+/)
			if !@positions.all?{|x| x.to_i.between?(0, @board_size)}
				puts "Invalid number" 
			else
				@x = @positions[0].to_i 
				@y = @positions[1].to_i
			end
		end

		if player_id == 1
			 if @board_positions[@x][@y] == "| |"  
			 	@board_positions[@x][@y] = "|x|" 
			 else 
			 	puts "Position ocupied"
			 	add(player_id)
			 end
		else 
			if @board_positions[@x][@y] == "| |" 
			  @board_positions[@x][@y] = "|o|"  
		 	else
		 		puts "Position ocupied"
		 		add(player_id)
		  	end 
		end
		update
	end 

	def change_turn(player1, player2)
		if @turn_swap == 1
			add(player1.player_id)
			@turn_swap = 2
		else
			add(player2.player_id)
			@turn_swap = 1
		end
	end

	def check_winner
		@circle = 0
		@blank = 0
		@board_positions.map do|k, v| 
			for i in 0..@board_size
				if @blank == @board_positions.length  
					@on_game = false
					return puts "Player 1 wins!"
				else
					v[i] == "|x|" ? @blank += 1 : @blank = 0
				end
			end 
		end
		
		for i in 0..@board_size
			if @blank == @board_positions.length   
				@on_game = false
				return puts "Player 1 wins!"
			else
				@board_positions[i][i] == "|x|" ? @blank += 1 : @blank = 0
			
			end
		end   
		
		for i in @board_size..0
			if @blank == @board_positions.length   
				@on_game = false
				return puts "Player 1 wins!"
			else
				@board_positions[i][i] == "|x|" ? @blank += 1 : @blank = 0
			
			end
		end   

		@board_positions.map do|k, v| 
			for i in 0..@board_size
				if @circle == @board_positions.length  
					@on_game = false
					return puts "Player 2 wins!"
				else
					v[i] == "|o|" ? @circle += 1 : @circle = 0 
				end
			end
		end
		
		for i in 0..@board_size
			if @circle == @board_positions.length   
				@on_game = false
				return puts "Player 2 wins!"
			else
				@board_positions[i][i] == "|o|" ? @circle += 1 : @circle = 0 
			end
		end
		
		for i in @board_size..0
			if @circle == @board_positions.length   
				@on_game = false
				return puts "Player 2 wins!"
			else
				@board_positions[i][i] == "|o|" ? @circle += 1 : @circle = 0 
			end
		end
		
		on_game = false if @board_positions.all?{|x| x != "| |"}
	end

	def restart 
		puts "Do you wish to restart? (y/n)"
		@answer = gets.chomp.downcase
		@answer == "y" ? create :  abort("Thank you for playing!")
	end

	def run(player1, player2)
		while on_game 
			change_turn(player1, player2)
		end
		restart
	end

end

player1 = Player.new()
player2 = Player.new()
game = Game.new()

while true
	game.run(player1, player2)	
end



