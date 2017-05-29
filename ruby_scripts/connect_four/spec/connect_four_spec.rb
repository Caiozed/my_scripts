require "connect_four"

def data_input(input)
	game.res = input
end


def pos (input)
	game.pos = input
	game.pos_array = game.pos.split(/\D+/) 
end

describe ConnectFour do 
	let (:game)	{ConnectFour.new}
	describe "#setup" do
		context "given an resolution less than 4" do
			it "Returns 'choose a valid board size!'" do
				data_input(1)
				expect(game.res).to eql(1)
			end
		end

		context "given a valid number" do
			it "calls 'create_board' method" do
				data_input(5)
				expect(game.res).to eql(5)
			end
		end
	end

	describe "#create_board" do 
		context "given a board resolution of 10" do
			it "Returns board size" do
				data_input(10)
				answer = game.board.all?{|h,k| k == "| |"}
				expect(answer).to eql(true)
			end
		end
	end

	describe "#draw" do
		context "given a resolution of 5" do 
			it "Returns a board drawing" do
				data_input(5)
				answer = game.board.all?{|h,k| k == "| |"}
				expect(answer).to eql(true)
			end
		end
	end

	describe "#turn" do 
		context "given '1 1' as positions" do 
			it "Returns a not empty position array'" do 
				pos("1 1")
				expect(game.pos_array).not_to be_empty  
			end
		end
	end

	describe "#check_input" do
		context "given an empty position" do
			it "Returns 'i need positions!'" do 
				expect(game.check_input).to eql(false)  
			end
		end

		context "given a invalid position" do 
			it "Returns 'not a valid position!'" do
				data_input(5)
				expect(game.check_input(-1,-1)).to eql(false)  
			end
		end

		context "given a position already filled" do 
			it "Returns 'position already filled!'" do
				data_input(5)
				game.board[1][1] = "|R|"
				expect(game.check_input(1,1)).to eql(false)  
			end
		end

		context "given a valid position" do 
			it "Returns 'position inserted!'" do
				data_input(5)
				game.board[1][1] = "| |"
				expect(game.check_input(1,1)).to eql(true)  
			end
		end
	end

	describe "#switch_player" do
		context "Given a value of '|Y|'" do
			it "Returns '|R|'" do 
				expect(game.switch_player("|Y|")).to eql("|R|")
			end
		end

		context "Given a value of '|R|'" do
			it "Returns '|Y|'" do 
				expect(game.switch_player("|R|")).to eql("|Y|")
			end
		end
	end

	describe "#check_winner" do 
		context "Given that a row is filled red" do
			it "Returns red wins" do
				data_input(5)
				for i in 0..game.res
					game.board[0][i] = "|R|"
				end
				expect(game.check_winner("|R|")).to eql(true)
			end
		end

		context "Given that a row is filled yellow" do
			it "Returns yellow wins" do
				data_input(5)
				for i in 0..game.res
					game.board[0][i] = "|Y|"
				end
				expect(game.check_winner("|Y|")).to eql(true)
			end
		end

		context "Given that a diagonal is filled red" do
			it "Returns red wins" do
				data_input(5)
				for i in 0..game.res
					game.board[i][i] = "|R|"
				end
				expect(game.check_winner("|R|")).to eql(true)
			end
		end

		context "Given that a diagonal is filled yellow" do
			it "Returns yellow wins" do
				data_input(5)
				for i in 0..game.res
					game.board[i][i] = "|Y|"
				end
				expect(game.check_winner("|Y|")).to eql(true)
			end
		end

		context "Given that a upward diagonal is filled red" do
			it "Returns red wins" do
				data_input(5)
				for i in 0..game.res
					game.board[i][game.res-i] = "|R|"
				end
				expect(game.check_winner("|R|")).to eql(true)
			end
		end

		context "Given that a upward diagonal is filled yellow" do
			it "Returns yellow wins" do
				data_input(5)
				for i in 0..game.res
					game.board[i][game.res-i] = "|Y|"
				end
				expect(game.check_winner("|Y|")).to eql(true)
			end
		end

		context "Given that no one wins yet" do
			it "Returns false" do
				data_input(5)
				for i in 0..game.res
					game.board[i][i] = "| |"
				end
				expect(game.check_winner).to eql(false)
			end
		end
	end

	describe "game_over" do 
		context "Given a full board" do 
			it "Return 'game over'" do 
				data_input(5)
				for i in 0..game.res
					for j in 0..game.res
						game.board[i][j] = "|R|"
					end
				end
				expect(game.game_over?).to eql(true)
			end
		end

		context "Given a not full board" do 
			it "Return 'game over'" do 
				data_input(5)
				for i in 0..game.res
					for j in 0..game.res
						game.board[i][j] = "| |"
					end
				end
				expect(game.game_over?).to eql(false)
			end
		end
	end
end