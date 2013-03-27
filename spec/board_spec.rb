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

			it "flips a red piece to a black piece" do
				board.grid[3][3].color.should == :red
				board.flip([3,2], :black, [0,1])
				board.grid[3][3].color.should == :black
			end

			it "flips a black piece to a red piece" do
				board.grid[2][3].color.should == :black
				board.grid[3][4].color.should == :black
				board.flip([2,4], :red, [0,-1])
				board.flip([2,4], :red, [1,0])
				board.grid[2][3].color.should == :red
				board.grid[3][4].color.should == :red
			end
	end


	describe "#valid_move?" do

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

		it "returns true if place to be is valid" do
			board.valid_move?(:black, [3,2]).should be_true
			board.valid_move?(:red, [2,4] ).should be_true
		end

		it "returns false if the place to be is not valid" do
			board.valid_move?(:black, [5,2]).should be_false
			board.valid_move?(:red, [5,2]).should be_false
			board.valid_move?(:black, [5,0]).should be_false
		end

	end


	describe "#place" do

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


		it "places a piece when the move is valid" do
			board.grid[2][4].should be_nil
			board.place(:red,[2, 4])
			board.grid[2][4].color.should == :red
		end

		it "flips captured pieces" do
			board.grid[2][3].color.should == :black
			board.grid[3][4].color.should == :black
			board.place(:red,[2, 4])
			board.grid[2][3].color.should == :red
			board.grid[3][4].color.should == :red
		end

		it "doesn't place piece when move is not valid" do
			board.place(:red,[5, 2])
			board.grid[5][2].should be_nil
			board.place(:red,[0, 0])
			board.grid[0][0].should be_nil
		end

	end

end