require 'chess.rb'

describe Chess do 
	let(:game) {Chess.new}

	describe "#setup" do 
		context "Given a method call" do 
			it "Returns the board drawn" do
				expect(game.setup).to receive(:draw)
			end
		end
	end
end