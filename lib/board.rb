#load './piece.rb'

class Board

	attr_accessor :grid, :red_pieces, :black_pieces

	def initialize
		self.grid = Array.new(8) {Array.new(8)}
		self.grid[3][3] = Piece.new(:red, [3, 3])
		self.grid[3][4] = Piece.new(:black, [3, 4])
		self.grid[4][3] = Piece.new(:black, [4, 3])
		self.grid[4][4] = Piece.new(:red, [4, 4])
		self.red_pieces = [grid[3][3], grid[4][4]]
		self.black_pieces = [grid[3][4], grid[4][3]]
	end

	def straight?(piece, position)
		piece_row = piece.position[0]
		piece_col = piece.position[1]
		play_row = position[0]
		play_col = position[1]
		return true if piece_row == play_row || piece_col == play_col
		return true if (piece_row - play_row).abs == (piece_col- play_col).abs
		false
	end

	# def get_path(start_pos, end_pos)
	# 	output = []
	# 	if start_pos[0] == end_pos[0] && start_pos[1] < end_pos[1]
	# 		start_pos[1].upto(end_pos[1]) do |indx|
	#
	# end

	def place_piece(position, color)
		row = position[0]
		col = position[1]
		return unless valid_move?(position, color)
		grid[row][col] = Piece.new(color, position)
	end


end