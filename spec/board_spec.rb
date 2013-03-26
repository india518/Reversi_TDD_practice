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
		let(:red1_piece) {Piece.new([1, 5], :red)}
		let(:blk1_piece) {Piece.new([3, 7], :black)}
		let(:red2_piece) {Piece.new([2, 0], :red)}
		let(:blk2_piece) {Piece.new([2, 3], :black)}

		before do
			board.grid[1][5] = red1_piece
			board.grid[3][7] = blk1_piece
			board.grid[2][0] = red2_piece
			board.grid[2][3] = blk2_piece
		end

		it "takes the location in play and returns valid directions" do
			board.get_direction([1, 5]).should == [[-1, -1]]
			board.get_direction([3, 7]).should == [[ 0, -1]]
			board.get_direction([2, 3]).should include([-1, 0])
			board.get_direction([2, 3]).should include([1, 1])
		end

    it "returns nil if there is no valid direction" do
			board.get_direction([2, 0]).should be_nil
		end
	end


	describe "#adjacant_enemy" do

		let(:board) {Board.new}
		let(:red_piece) {Piece.new([2,2], :red)}
		let(:blk_piece) {Piece.new([2,2], :black)}

		before do
			board.grid[2][2] = red_piece
			board.grid[2][5] = blk_piece
		end

		it "returns true if next to enemy" do
			board.adjacent_enemy([3, 3]).should be_true
			board.adjacent_enemy([3, 4]).should be_true
		end

		it "returns false if not next to enemy" do
			board.adjacent_enemy([2, 2]).should be_false
			board.adjacent_enemy([2, 5]).should be_false
		end

	end


	describe "#straight?" do
		describe "returns true for a straight line b/w square in play and a piece" do
			let(:piece) {Piece.new(:red, [3, 3])}
			let(:board) {Board.new}

			it "returns true when there is a straight line" do
				board.straight?(piece, [0, 0]).should be_true
				board.straight?(piece, [0, 3]).should be_true
				board.straight?(piece, [4, 3]).should be_true
				board.straight?(piece, [3, 0]).should be_true
				board.straight?(piece, [1, 5]).should be_true
				board.straight?(piece, [3, 7]).should be_true
				board.straight?(piece, [4, 4]).should be_true
				board.straight?(piece, [7, 3]).should be_true
				board.straight?(piece, [7, 3]).should be_true
			end

			it "returns false when there is a straight line" do
				board.straight?(piece, [0, 1]).should be_false
				board.straight?(piece, [4, 5]).should be_false
				board.straight?(piece, [7, 4]).should be_false
			end

		end
	end

	describe "#get_path" do

		it "returns an array of positions(arrays) between two positions" do
			get_path([3, 3],[0, 0]).should == [[2, 2], [1, 1]]
			get_path([3, 3],[0, 3]).should == [[2, 3], [1, 3]]
			get_path([3, 3],[4, 3]).should == []
			get_path([3, 3],[3, 0]).should == [[3, 2], [3, 1]]
			get_path([3, 3],[1, 5]).should == [[2, 4]]
			get_path([3, 3],[3, 7]).should == [[3, 4], [3, 5], [3, 6]]
			get_path([3, 3],[4, 4]).should == []
			get_path([3, 3],[7, 3]).should == [[4, 3], [5, 3], [6, 3]]
		end
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