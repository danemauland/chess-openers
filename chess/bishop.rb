require_relative "slideable.rb"
class Bishop < Piece
    include Slideable

    def symbol
        ' ♝ '.colorize(color)
    end

    protected
    def move_dirs
        horizontal = false
        diagonal = true
        [horizontal, diagonal]
    end

end