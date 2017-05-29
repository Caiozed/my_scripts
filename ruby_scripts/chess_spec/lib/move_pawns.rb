class MovePawns
	def self.insert_position(move_to, current, board, pawn)
		if board[move_to[0]][move_to[1]][1] == pawn[1]
			puts "Position already ocupied!"	
		else
			board[move_to[0]][move_to[1]] = pawn
			board[current[0]][current[1]] = "|  |"
		end
	end

	def self.check_position(y, x, move_to, current, board, pawn)
		if board[y][x][1] != "#{pawn[1]}"
			MovePawns.insert_position(move_to, current, board, pawn)
		else
			puts "Not a valid movement!"
			return true
		end
	end

	def self.omini_direction_move(move_to, current, board, pawn)	
		if move_to[0] == current[0]-1 && move_to[1] == current[1]
				MovePawns.insert_position(move_to, current, board, pawn)
			elsif move_to[0] == current[0]-1 && move_to[1] == current[1]-1
				MovePawns.insert_position(move_to, current, board, pawn)
			elsif move_to[0] == current[0]-1 && move_to[1] == current[1]+1
				MovePawns.insert_position(move_to, current, board, pawn)
			elsif move_to[0] == current[0]+1 && move_to[1] == current[1]
				MovePawns.insert_position(move_to, current, board, pawn)
			elsif move_to[0] == current[0]+1 && move_to[1] == current[1]-1
				MovePawns.insert_position(move_to, current, board, pawn)
			elsif move_to[0] == current[0]+1 && move_to[1] == current[1]+1
				MovePawns.insert_position(move_to, current, board, pawn)
			end
	end

	def self.diagonal_move(move_to, current, board, pawn)
		iteration_x = 0
		iteration_y = 0
		potentials = []
	    potentials.push(
	      [current[1] + 1, current[0] + 1],
	      [current[1] + 2, current[0] + 2],
	      [current[1] + 3, current[0] + 3],
	      [current[1] + 4, current[0] + 4],
	      [current[1] + 5, current[0] + 5],
	      [current[1] + 6, current[0] + 6],
	      [current[1] + 7, current[0] + 7],
	      [current[1] - 1, current[0] + 1],
	      [current[1] - 2, current[0] + 2],
	      [current[1] - 3, current[0] + 3],
	      [current[1] - 4, current[0] + 4],
	      [current[1] - 5, current[0] + 5],
	      [current[1] - 6, current[0] + 6],
	      [current[1] - 7, current[0] + 7],
	      [current[1] + 1, current[0] - 1],
	      [current[1] + 2, current[0] - 2],
	      [current[1] + 3, current[0] - 3],
	      [current[1] + 4, current[0] - 4],
	      [current[1] + 5, current[0] - 5],
	      [current[1] + 6, current[0] - 6],
	      [current[1] + 7, current[0] - 7],
	      [current[1] - 1, current[0] - 1],
	      [current[1] - 2, current[0] - 2],
	      [current[1] - 3, current[0] - 3],
	      [current[1] - 4, current[0] - 4],
	      [current[1] - 5, current[0] - 5],
	      [current[1] - 6, current[0] - 6],
	      [current[1] - 7, current[0] - 7]
	      )
		valid_children = potentials.select do |i|
      		i[0].between?(0,8) &&
      		i[1].between?(0,8)
    	end
   
		if valid_children.include? [move_to[1], move_to[0]]
			if move_to[0] > current[0] && move_to[1] > current[1]
				for i in (current[0]).upto(move_to[0])
					iteration_x = current[1] + 1
					iteration_y = current[0] + 1
					break if MovePawns.check_position(iteration_y, iteration_x, move_to, current, board, pawn)
				end
			elsif move_to[0] > current[0] && move_to[1] < current[1]
				for i in (current[0]).upto(move_to[0])
					iteration_x = current[1] - 1
					iteration_y = current[0] + 1
					break if MovePawns.check_position(iteration_y, iteration_x, move_to, current, board, pawn)
				end  
			elsif move_to[0] < current[0] && move_to[1] > current[1]
				for i in (current[0]).downto(move_to[0])
					iteration_x = current[1] + 1
					iteration_y = current[0] - 1
					break if MovePawns.check_position(iteration_y, iteration_x, move_to, current, board, pawn)
				end
			elsif move_to[0] < current[0] && move_to[1] < current[1]
				for i in (current[0]).downto(move_to[0])
					iteration_x = current[1] - 1
					iteration_y = current[0] - 1
					break if MovePawns.check_position(iteration_y, iteration_x, move_to, current, board, pawn)
				end
			end
		end
	end

	def self.linear_move(move_to, current, board, pawn)
		iteration_x = 0
		iteration_y = 0
		potentials = []
	    potentials.push(
	      [current[1] + 1, current[0]],
	      [current[1] + 2, current[0]],
	      [current[1] + 3, current[0]],
	      [current[1] + 4, current[0]],
	      [current[1] + 5, current[0]],
	      [current[1] + 6, current[0]],
	      [current[1] + 7, current[0]],
	      [current[1], current[0] + 1],
	      [current[1], current[0] + 2],
	      [current[1], current[0] + 3],
	      [current[1], current[0] + 4],
	      [current[1], current[0] + 5],
	      [current[1], current[0] + 6],
	      [current[1], current[0] + 7],
	      [current[1] - 1, current[0]],
	      [current[1] - 2, current[0]],
	      [current[1] - 3, current[0]],
	      [current[1] - 4, current[0]],
	      [current[1] - 5, current[0]],
	      [current[1] - 6, current[0]],
	      [current[1] - 7, current[0]],
	      [current[1], current[0] - 1],
	      [current[1], current[0] - 2],
	      [current[1], current[0] - 3],
	      [current[1], current[0] - 4],
	      [current[1], current[0] - 5],
	      [current[1], current[0] - 6],
	      [current[1], current[0] - 7]
	      )

	    valid_children = potentials.select do |i|
	      i[0].between?(0,8) &&
	      i[1].between?(0,8)
	    end
	    	
		if valid_children.include? [move_to[1], move_to[0]]
			if move_to[0] > current[0]
				for i in (current[0]).upto(move_to[0])
					iteration_y = current[0] + 1
					break if MovePawns.check_position(iteration_y, current[1], move_to, current, board, pawn)
				end
			elsif move_to[0] < current[0]
				for i in (current[0]).downto(move_to[0])
					iteration_y = current[0] - 1
					break if MovePawns.check_position(iteration_y, current[1], move_to, current, board, pawn)
				end
			elsif move_to[1] > current[1]
				for i in (current[1]).upto(move_to[1])
					iteration_x = current[1] + 1
					break if MovePawns.check_position(current[0], iteration_x, move_to, current, board, pawn)
				end
			elsif move_to[1] < current[1]
				for i in (current[1]).downto(move_to[1])
					iteration_x = current[1] - 1
					break if MovePawns.check_position(current[0], iteration_x, move_to, current, board, pawn)
				end
			end
		end
	end

	def self.move_pawn(move_to, current, board, current_player)
		MovePawns.omini_direction_move(move_to, current, board, "|#{current_player}P|")
		board
	end

	def self.move_tower(move_to, current, board,current_player)	
		MovePawns.linear_move(move_to, current, board, "|#{current_player}T|")
		board
	end

	def self.move_horse(move_to, current, board, current_player)	
		potentials = []
		potentials.push(
			[current[1] + 2, current[0] - 1],
			[current[1] + 2, current[0] + 1],
			[current[1] + 1, current[0] - 2],
			[current[1] + 1, current[0] + 2],
			[current[1] - 2, current[0] - 1],
			[current[1] - 2, current[0] + 1],
			[current[1] - 1, current[0] - 2],
			[current[1] - 1, current[0] + 2],
		)

		valid_children = potentials.select{|i| i[0].between?(0,8) && i[1].between?(0,8)}

		if valid_children.include? [move_to[1], move_to[0]]
			MovePawns.insert_position(move_to, current, board, "|#{current_player}H|")
		else
			puts "Not a valid movement!"
		end
		board
	end

	def self.move_bishop(move_to, current, board, current_player)
		MovePawns.diagonal_move(move_to, current, board, "|#{current_player}B|")
		board
	end

	def self.move_queen(move_to, current, board, current_player)
		MovePawns.diagonal_move(move_to, current, board, "|#{current_player}Q|")
		MovePawns.linear_move(move_to, current, board, "|#{current_player}Q|")
		board
	end

	def self.move_king(move_to, current, board, current_player)
		MovePawns.omini_direction_move(move_to, current, board, "|#{current_player}K|")
		board
	end
end