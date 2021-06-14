module Slideable

     def moves
        moves = []
        moves.concat(horizontal_dirs) if move_dirs[0]
        moves.concat(diagonal_dirs) if move_dirs[1]
        moves
     end

    private
    def move_dirs
        [true, true]
    end

    def grow_unblocked_moves_in_dir(dir)
        moves = []
        dx, dy = dir
        new_x, new_y = pos[0] + dx, pos[1] + dy
        until !position_is_valid?([new_x,new_y]) || !position_is_empty?([new_x,new_y])
            moves << [new_x, new_y]
            new_x += dx
            new_y += dy
        end
        moves << [new_x, new_y] if position_is_valid?([new_x,new_y]) && piece_is_enemy_color?([new_x,new_y])
        moves
    end

    def horizontal_dirs
        moves = []
        HORIZONTAL_DIRS.each {|dir| moves.concat(grow_unblocked_moves_in_dir(dir))}
        moves
     end

     def diagonal_dirs
        moves = []
        DIAGONAL_DIRS.each {|dir| moves.concat(grow_unblocked_moves_in_dir(dir))}
        moves
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

    HORIZONTAL_DIRS = [
        [0,1],
        [0,-1],
        [1,0],
        [-1,0],
 
    ]
    DIAGONAL_DIRS = [
        [1,1],
        [-1,-1],
        [1,-1],
        [-1,1]
    ]
end