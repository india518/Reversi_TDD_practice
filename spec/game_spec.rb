require 'rspec'
require 'game'
require 'board'

describe Game do

	describe "#initialize" do

		it "it initializes the game" do
			board = double('board')
			board.should_receive(:new)
			game = Game.new
		end

	end

	describe "#place_piece" do

		let(:game) { Game.new }

		it "tells the board to place a piece" do
			position = [0,0]
			color = :red
			board = double('board')
			board.should_receive(:place).with(position, color)
			game.place_piece(position, color)
		end

	end

end