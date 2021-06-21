class Pawn < Piece

    def symbol
        ' P '.colorize(color)
    end

    def moves
        forward_moves + side_attacks
    end
        
    def fen
        color == :white ? 'P' : 'p'
    end

    def at_start_row?
        (color == :white && pos[0] == 6) || (color == :black && pos[0] == 1)
    end

    def is_pawn?
        true
    end

    private
    def forward_moves
        moves = []
        (1..forward_steps).each do |step|
            new_x = pos[0] + step * forward_dir
            new_y = pos[1]
            new_pos = [new_x, new_y]
            break if !position_is_valid?(pos) || !position_is_empty?(new_pos)
            moves << new_pos
        end
        moves
    end

    

    def forward_dir
        color == :white ? -1 : 1
    end

    def forward_steps
        at_start_row? ? 2 : 1
    end

    def side_attacks
        attacks = []
        x, y = pos
        left_attack_pos = [x + forward_dir, y - 1]
        right_attack_pos = [x + forward_dir, y + 1]
        attacks << left_attack_pos if position_is_valid?(left_attack_pos) && piece_is_enemy_color?(left_attack_pos)
        attacks << right_attack_pos if position_is_valid?(right_attack_pos) && piece_is_enemy_color?(right_attack_pos)
        attacks
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
        (!position_is_empty?(pos) && board.rows[x][y].color != color) || board.is_en_passant?(pos)
    end

    
end