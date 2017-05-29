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
		@x=-1
		@y=-1
		@color = ""
		@colors = ["blue", "orange", "red", "white", "green", "yellow", "pink" ]
		@turns = 13                                           
		while !@board_size.between?(@min_size, @max_size)
			puts "Define the size of the game board between #{@min_size} and #{@max_size} :"
			@board_size = gets.chomp.to_i
			puts "Invalid number" if !@board_size.between?(@min_size, @max_size)
		end
		draw
	end

	def draw 
		@picked_colors = Hash.new{|h, k| h[k] = []}
		@board_positions = Hash.new{|h, k| h[k] = []}
		for i in 0..@board_size 
			for j in 0..@board_size 
				@board_positions[i][j] = "| |"
				@picked_colors[i][j] = @colors[rand(0.. @colors.length-1)]
			end
		end
	end

	def update
		puts "Current board:"
		print " * "
		for i in 0..@board_size
			print " #{i} "
		end
		puts ""
		@board_positions.each{|k, v| puts " #{k} #{v.join}"}
	end

	def spacing
		for i in 0..@color.length-1
			print " "
		end
	end

	def add
		puts "What position do you wish to place? "
		@positions =  gets.chomp.split(/\D+/)
		puts "What color do you pick?"
		puts "#{@colors.join(", ")}"
		@color = gets.chomp.downcase

		if !@positions.all?{|x| x.to_i.between?(0, @board_size)}
			puts "Invalid number" 
			add
		else
			@x = @positions[0].to_i 
			@y = @positions[1].to_i
		end

		if(!@colors.include?(@color))
			puts "Invalid color" 
			add
		end

		if @board_positions[@x][@y] != "| |"
			puts "Color already discovered!"  
			add 
		end
		check_winner
	end 

	def change_turn
		@turns -= 1
		if @turns <= 0
			puts "You lose!"
			restart
		else
			puts "#{@turns}, turns remaining!"
			update
			add
		end		
	end

	def check_winner
		@count = 0
					puts @picked_colors
		if @picked_colors[@x][@y] == @color
			puts "Correct!"
			@board_positions[@x][@y] = "|#{@color}|"
		else
			for i in 0..@board_size 
				for j in 0..@board_size 
				if @picked_colors[i][j] == @color
						@count+=1
					end
				end
			end
			puts @count > 0 ? "#{@count} in the board, but not here!" : "No such color!" 
			@count = 0
		end
	 
		for i in 0..@board_size 
			for j in 0..@board_size 
			if @board_positions[i][j] != "| |"
					puts @count+=1
				end
			end
		end
		
		if @count == (@board_size+1)*(@board_size+1)
			update
			puts "Congratz you win!"
			restart
		else
			change_turn
		end
		
	end

	def restart 
		puts "Do you wish to restart? (y/n)"
		@answer = gets.chomp.downcase
		@answer == "y" ? create :  abort("Thank you for playing!")
	end

	def run
		change_turn		
	end
end