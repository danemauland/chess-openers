require_relative "slideable.rb"
require_relative "piece.rb"

class Queen < Piece
    include Slideable

    def symbol
        ' ♛ '.colorize(color)
    end

    protected
    def move_dirs
        horizontal = true
        diagonal = true
        [horizontal, diagonal]
    end

end