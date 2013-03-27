require 'rspec'
require 'game'
require 'board'

describe Game do

	describe "#initialize" do

		it "it initializes the game" do

			board = double('board')
			game = Game.new(board)
			game.board.should be_true
		end

		#REV I'm not sure how game.board == true is testing the initialize method here 

	end

	describe "#place_piece" do
		let(:board) { double('board') }
		subject(:game) { Game.new(board) }

		it "tells the board to place a piece" do
			position = [0,0]
			color = :red
			#REV I think you really want to be testing board.should_receive(:place) here... board is the class that holds the place method right?
			game.board.should_receive(:place).with(color, position)
			game.place_piece(position, color)
		end

	end

end