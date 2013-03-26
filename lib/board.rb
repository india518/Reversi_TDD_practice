#load './piece.rb'
require 'debugger'
# require_relative 'piece'

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

	def on_board?(pos)
		(0..7).include?(pos[0]) && (0..7).include?(pos[1])
	end

	def get_direction(color, pos)
		output = []
		direction_vectors = [[0, 1],
												 [1, 1],
												 [1, 0],
												 [1, -1],
												 [0, -1],
												 [-1, -1],
												 [-1, 0],
												 [-1, 1]]
		direction_vectors.each do |direction|
			output << direction if same_color_in_this_direction?(color, pos, direction)
		end
		output
	end

	def same_color_in_this_direction?(color, pos, direction)
		# debugger
		# returns true / false
		space_to_check = [pos[0] + direction[0], pos[1] + direction[1]]
		return false if grid[space_to_check[0]][space_to_check[1]].nil?
		return false if grid[space_to_check[0]][space_to_check[1]].color == color
		until grid[space_to_check[0]][space_to_check[1]].nil?
			return true if grid[space_to_check[0]][space_to_check[1]].color == color
			space_to_check = [space_to_check[0] + direction[0], space_to_check[1] + direction[1]]
		end
		false
	end

	def place_piece(position, color)
		row = position[0]
		col = position[1]
		return unless valid_move?(position, color)
		grid[row][col] = Piece.new(color, position)
	end


end

=begin
board = Board.new
red1_piece = Piece.new(:red, [1, 5])
blk1_piece = Piece.new(:black, [3, 7])
red2_piece = Piece.new(:red, [2, 0])
blk2_piece = Piece.new(:black, [2, 3])
blk3_piece = Piece.new(:black, [2,4])
board.grid[1][5] = red1_piece
board.grid[3][7] = blk1_piece
board.grid[2][0] = red2_piece
board.grid[2][3] = blk2_piece
board.grid[2][4] = blk3_piece
board.same_color_in_this_direction?([1, 5],[1, -1])
=end