require_relative "stepable"
class King < Piece
    include Stepable
    
    def symbol
        ' ♚ '.colorize(color)
    end

    def fen
        color == :white ? 'K' : 'k'
    end

    def is_king?
        true
    end

    protected
    def move_diffs
        [
            [1,1],
            [1,0],
            [1,-1],
            [0,1],
            [0,-1],
            [-1,1],
            [-1,0],
            [-1,-1]
        ]
    end

end