require "colorize"

class Display

    def initialize(board)
        @board = board
    end

    def render
        new_rows = []
        @board.rows.each_with_index do |row, x|
            new_row = []
            row.each_with_index do |piece, y|
                new_row << piece.symbol.colorize(background: :light_black) if (x + y).even?
                new_row << piece.symbol.colorize(background: :red) if (x + y).odd?
            end
            new_rows << new_row
        end
        puts new_rows.map {|row| row.join("")}.join("\n")
    end
end