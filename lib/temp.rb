
find_line(pos)
	red_pieces.each do |piece|

1) Go through all of your pieces and find those with
	straight lines (cant be next to your piece, no
	horse-type move).  Return as array of arrays or nil
	ex: [[[1,2][2,2]],[]]

	output = []
	red_pieces.each do |piece|
		output << get_path(piece, position) if straight?(piece, position)
	end
	output

	def straight?(piece, position)
		piece_row = piece.position[0]
		piece_col = piece.position[1]
		play_row = position[0]
		play_col = position[1]
		return true if piece_row == play_row || piece_col == play_col
		return true if (piece_row - play_row).abs == (piece_col- play_col).abs
		false
	end


2) pass the array of arrays to valid_move?

