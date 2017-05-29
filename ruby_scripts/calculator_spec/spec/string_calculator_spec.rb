require "string_calculator"

describe StringCalculator do
	describe ".add" do
		context "given an empty string" do
			it "Returns zero" do
				expect(StringCalculator.add("")).to eql(0)
			end
		end

		context "given '4'" do
			it "Returns 4" do
				expect(StringCalculator.add("4")).to eql(4)
			end
		end

		context "two numbers" do 
			context "given '2,4'" do
				it "Returns 6" do
					expect(StringCalculator.add("2,4")).to eql(6)
				end
			end

			context "given '17,100'" do 
				it "Returns 117" do
					expect(StringCalculator.add("17,100")).to eql (117)
				end
			end
		end
	end	
end