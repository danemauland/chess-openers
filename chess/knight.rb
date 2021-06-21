require_relative "stepable"
class Knight < Piece
    include Stepable
    def symbol
        ' ♞ '.colorize(color)
    end

    def fen
        color == :white ? 'N' : 'n'
    end

    protected
    def move_diffs
        [
            [2,1],
            [2,-1],
            [-2,1],
            [-2,-1],
            [1,2],
            [1,-2],
            [-1,2],
            [-1,-2]
        ]
    end


end