require_relative "slideable.rb"
class Rook < Piece
    include Slideable

    attr_accessor :can_castle
    def initialize(color, board, pos)
        super(color, board, pos)
        @can_castle = true
    end

    def pos=(val)
        can_castle = false
        super(val)
    end
 
    def symbol
        ' ♜ '.colorize(color)
    end

    def fen
        color == :white ? 'R' : 'r'
    end

    protected
    def move_dirs
        horizontal = true
        diagonal = false
        [horizontal, diagonal]
    end
end