require 'rspec'
require 'board'
require 'piece'

describe Board do

	describe "creates the starting board" do

		let(:board) {Board.new}

		it "returns an 8x8 grid" do

			board.grid.size.should == 8
			board.grid.each do |row|
				row.size.should == 8
			end
		end

		it "places four pieces in the correct start position" do
			board.grid[3][3].color.should == :red
			board.grid[3][4].color.should == :black
			board.grid[4][3].color.should == :black
			board.grid[4][4].color.should == :red
		end

		it "should have an array for each player with two pieces in play" do
			board.red_pieces.count.should == 2
			board.black_pieces.count.should == 2
		end

		it "should have the arrays contain the correct pieces" do

			board.red_pieces.each do |piece|
				piece.color.should == :red
			end

			board.black_pieces.each do |piece|
				piece.color.should == :black
			end

		end

	end

=begin
	describe "displays the board" do
		let(:board) {Board.new}
		it "#display" do
			board.display.should ==
		end
	end
=end

	describe "#on_board?" do

		let(:board) { Board.new }

		it "returns true if position is on board" do
			board.on_board?([3,3]).should be_true
		end

		it "returns false if position is not on board" do
			board.on_board?([-1,1]).should be_false
			board.on_board?([0,10]).should be_false
		end

	end

	describe "#get_direction" do
		let(:board) {Board.new}
		let(:red1_piece) {Piece.new(:red, [1, 5])}
		let(:blk1_piece) {Piece.new(:black, [3, 7])}
		let(:red2_piece) {Piece.new(:red, [2, 0])}
		let(:blk2_piece) {Piece.new(:black, [2, 3])}
		let(:red3_piece) {Piece.new(:red, [2, 2])}

		before do
			board.grid[1][5] = red1_piece
			board.grid[3][7] = blk1_piece
			board.grid[2][0] = red2_piece
			board.grid[2][3] = blk2_piece
			board.grid[2][2] = red3_piece
		end

		it "takes the location in play and returns valid directions" do
			board.get_direction(:black, [3, 2]).should include([0, 1])
			board.get_direction(:red, [2, 4]).should include([0, -1])
			board.get_direction(:red, [2, 4]).should include([1, 0])
		end

    it "returns empty if there is no valid direction" do
			board.get_direction(:red, [1, 4]).should be_empty
			board.get_direction(:red, [0, 0]).should be_empty
			board.get_direction(:black, [5, 2]).should be_empty
			board.get_direction(:red, [5, 2]).should be_empty
		end
	end

  describe "#same_color_in_this_direction?" do
		# returns false if hits empty space in the direction or
		# off the board and still not friendly piece
		let(:board) {Board.new}
		let(:red1_piece) {Piece.new(:red, [1, 5])}
		let(:blk1_piece) {Piece.new(:black, [3, 7])}
		let(:red2_piece) {Piece.new(:red, [2, 0])}
		let(:blk2_piece) {Piece.new(:black, [2, 3])}
		let(:red3_piece) {Piece.new(:red, [2, 2])}

		before do
			board.grid[1][5] = red1_piece
			board.grid[3][7] = blk1_piece
			board.grid[2][0] = red2_piece
			board.grid[2][3] = blk2_piece
			board.grid[2][2] = red3_piece
		end


		it "returns true if we find a piece.color in this direction" do
			board.same_color_in_this_direction?(:black, [3, 2], [0, 1]).should be_true
			board.same_color_in_this_direction?(:red, [2, 4], [0, -1]).should be_true
			board.same_color_in_this_direction?(:red, [2, 4], [1, 0]).should be_true

		end

		it "returns false if no matchin piece.color found" do
			board.same_color_in_this_direction?(:red, [1, 4],[0,1]).should be_false
			board.same_color_in_this_direction?(:red, [2, 0], [1, 0]).should be_false
			board.same_color_in_this_direction?(:black, [2, 0], [1, 0]).should be_false
			board.same_color_in_this_direction?(:red, [1, 5],[1, -1]).should be_false
			board.same_color_in_this_direction?(:black, [1, 5],[1, -1]).should be_false
			board.same_color_in_this_direction?(:black ,[5, 2],[-1, 1]).should be_false
		end

	end

	describe "#flip" do


	end

	describe "#find_line" do
		# also checks

		describe "checks for a line to each piece in the player's pieces array" do

			let(:board) {Board.new}

			it "returns a valid path" do
				board.find_line([2, 4]).should == [3, 4]
			end

			it "returns nil if there is no path" do
				board.find_line([3, 2]).should be_nil
				board.find_line([0, 0]).should be_nil
			end



		end

	end

=begin
	describe "#valid_move?" do

		let(:myboard) {Board.new}

		it "returns false if position is not nil" do
			myboard.valid_move?([3,3], :red).should be_false
		end

		it "returns false if position is not on board" do
			myboard.valid_move?([10,10], :black).should be_false
		end

		it "returns true if the move captures enemy piece(s)" do
			myboard.valid_move?([2,4], :red).should be_true
		end

		it "returns false if the move does not capture enemy piece" do
			myboard.valid_move?([2,3], :red).should be_false
		end

	end


	describe "#place_piece" do

		let(:myboard) { Board.new }

		it "places a new piece in valid position" do
			myboard.place_piece([2,4],:red)
			myboard.grid[2][4].color.should == :red
		end

		it "places the new piece into the player's array" do
	    FIND SYTNAX: myboard.red_pieces.should be_include


		it "flips a captured piece" do
			myboard.grid[3][4].color.should == :red
		end

	  it "removes the captures piece(s) from the other player's array"

		it "forbids placing a new piece in illegal position" do
			myboard.place_piece([0,0],:red)
			myboard.grid[0][0].should be_nil
		end

	end
=end



	it "should which pieces to flip" do
	end

	it "should check when the game is won" do
	end

	it "should keep track of points" do
	end


end