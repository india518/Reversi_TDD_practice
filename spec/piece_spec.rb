require 'rspec'
require_relative '../lib/piece'

describe Piece do

	before { @piece = Piece.new(:black,[4,3]) }

	describe "initializes correctly" do

		it "should have a color" do
			@piece.color.should == :black
		end

		it "should have a position" do
			@piece.position.should == [4,3]
		end

	end

	describe "should respond to board input"

		it "should flip it's color" do
			@piece.flip
			@piece.color.should == :red
		end

end