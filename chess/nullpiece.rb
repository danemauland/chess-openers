require "singleton"
class NullPiece < Piece
    include Singleton
    def initialize
    end

    def moves
        nil
    end

    def symbol
        "   "
    end

    def empty?
        true
    end

    def color
        :none
    end

end