module Stepable

    def moves
        moves = []
        move_diffs.each do |dif|
            new_x = pos[0] + dif[0]
            new_y = pos[1] + dif[1]
            new_pos = [new_x, new_y]
            moves << new_pos if position_is_valid?(new_pos) && (position_is_empty?(new_pos) || piece_is_enemy_color?(new_pos))
        end
        moves
    end

    private
    def move_diffs
        [[1,1]]
    end

    def position_is_valid?(pos)
        board.valid_pos?(pos)
    end

    def position_is_empty?(pos)
        x, y = pos
        board.rows[x][y].empty?
    end

    def piece_is_enemy_color?(pos)
        x, y = pos
        !position_is_empty?(pos) && board.rows[x][y].color != color
    end
end