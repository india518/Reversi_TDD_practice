class Piece

  attr_accessor :color
	attr_reader :position

	def initialize(color, position)
    @color = color
		@position = position
	end

  def flip
		return self.color = :red if color == :black
		self.color = :black if color == :red
	end

end