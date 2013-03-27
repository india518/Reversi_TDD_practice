class Game

	attr_accessor :board

	def initialize(board)
		self.board = board ||= Board.new
	end

	def place_piece(position, color)
		board.place(color, position)
	end


end