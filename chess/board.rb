require_relative "piece.rb"
require_relative "queen.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "knight.rb"
require_relative "nullpiece"
require_relative "pawn"
require_relative "display"
require "colorize"


class Board
    attr_reader :rows, :sentinel
    def set_up_board
        board = Array.new(8) {Array.new(8, @sentinel)}

        @black_queenside_rook = Rook.new(:black, self, [0,0])
        @black_kingside_rook = Rook.new(:black, self, [0,7])
        @black_rooks = [@black_queenside_rook, @black_kingside_rook]
        @black_knights = [Knight.new(:black, self, [0,1]), Knight.new(:black, self, [0,6])]
        @black_bishops = [Bishop.new(:black, self, [0,2]), Bishop.new(:black, self, [0,5])]
        @black_queen = Queen.new(:black, self, [0,3])
        @black_king = King.new(:black, self, [0,4])

        board[0][0] = @black_rooks.first
        board[0][7] = @black_rooks.last
        board[0][1] = @black_knights.first
        board[0][6] = @black_knights.last
        board[0][2] = @black_bishops.first
        board[0][5] = @black_bishops.last
        board[0][3] = @black_queen
        board[0][4] = @black_king

        @black_pawns = []
        (0..7).each do |i|
            pawn = Pawn.new(:black, self, [1,i])
            board[1][i] = Pawn.new(:black, self, [1,i])
            @black_pawns << pawn
        end

        @white_queenside_rook = Rook.new(:white, self, [7,0])
        @white_kingside_rook = Rook.new(:white, self, [7,7])
        @white_rooks = [@white_queenside_rook, @white_kingside_rook]
        @white_knights = [Knight.new(:white, self, [7,1]), Knight.new(:white, self, [7,6])]
        @white_bishops = [Bishop.new(:white, self, [7,2]), Bishop.new(:white, self, [7,5])]
        @white_queen = Queen.new(:white, self, [7,3])
        @white_king = King.new(:white, self, [7,4])

        board[7][0] = @white_rooks.first 
        board[7][7] = @white_rooks.last 
        board[7][1] = @white_knights.first 
        board[7][6] = @white_knights.last 
        board[7][2] = @white_bishops.first 
        board[7][5] = @white_bishops.last 
        board[7][3] = @white_queen 
        board[7][4] = @white_king 

        @white_pawns = []
        (0..7).each do |i|
            pawn = Pawn.new(:white, self, [6,i])
            board[6][i] = pawn
            @white_pawns.push(pawn)
        end

        board
    end

    def from_fen(fen)
        board = Array.new(8) {Array.new(8, @sentinel)}

        @black_queenside_rook = Rook.new(:black, self)
        @black_kingside_rook = Rook.new(:black, self)
        @black_rooks = [@black_queenside_rook, @black_kingside_rook]
        @black_knights = [Knight.new(:black, self), Knight.new(:black, self)]
        @black_bishops = [Bishop.new(:black, self), Bishop.new(:black, self)]
        @black_queen = Queen.new(:black, self)
        @black_king = King.new(:black, self)

        @black_pawns = []
        (0..7).each do |i|
            pawn = Pawn.new(:black, self)
            @black_pawns << pawn
        end

        @white_queenside_rook = Rook.new(:white, self)
        @white_kingside_rook = Rook.new(:white, self)
        @white_rooks = [@white_queenside_rook, @white_kingside_rook]
        @white_knights = [Knight.new(:white, self), Knight.new(:white, self)]
        @white_bishops = [Bishop.new(:white, self), Bishop.new(:white, self)]
        @white_queen = Queen.new(:white, self)
        @white_king = King.new(:white, self)

        @white_pawns = []
        (0..7).each do |i|
            pawn = Pawn.new(:white, self)
            @white_pawns.push(pawn)
        end

        fen_arr = fen.split(' ')
        fen_pieces = fen_arr.first.split('')
        
        row = 0;
        col = 0;

        while fen_pieces.length > 0 do
            piece = fen_pieces.shift
            case piece do
            when '/'
                row++
                col = 0
            when 'p'
                pawn = black_pawns.shift
                pawn.pos = [row, col]
                board[row][col] = pawn
                col++
            when 'r'
                rook = black_rooks.shift
                rook.pos = [row, col]
                board[row][col] = rook
                col++
            when 'n'
                knight = black_knights.shift
                knight.pos = [row, col]
                board[row][col] = knight
                col++
                
            when 'b'
                bishop = black_bishops.shift
                bishop.pos = [row, col]
                board[row][col] = bishop
                col++
                
            when 'q'
                black_queen.pos = [row, col]
                board[row][col] = black_queen
                col++
                
            when 'k'
                black_king.pos = [row, col]
                board[row][col] = black_king
                col++
                
            when 'P'
                pawn = white_pawns.shift
                pawn.pos = [row, col]
                board[row][col] = pawn
                col++
                
            when 'R'
                rook = white_rooks.shift
                rook.pos = [row, col]
                board[row][col] = rook
                col++
                
            when 'N'
                knight = white_knights.shift
                knight.pos = [row, col]
                board[row][col] = knight
                col++
                
            when 'B'
                bishop = white_bishops.shift
                bishop.pos = [row, col]
                board[row][col] = bishop
                col++
                
            when 'Q'
                white_queen.pos = [row, col]
                board[row][col] = white_queen
                col++
                
            when 'K'
                white_king.pos = [row, col]
                board[row][col] = white_king
                col++
                
            else
                col += piece.to_i
            end
        end

        board
    end

    def initialize(rows = nil, fen = nil)
        @sentinel = NullPiece.instance
        @rows = rows || fen ? from_fen(fen) : set_up_board
        @en_passant = nil
    end

    def get_piece_char(move)
        return 'P' if move[0].downcase == move[0]
        raise 'castling not yet supported' if move[0] == '0'
        return move[0]
    end

    def get_end_pos_str(move)
        return move if move.length < 3
        return move[2..3] if move[1] == 'x'
        return move[3..4] if move[2] == 'x'
        return move[1..2] if move[1].downcase == move[1] && move[2].downcase == move[2]
    end

    def get_end_pos(move)
        end_pos_str = get_end_pos_str(move)
        y = 'abcdefgh'.index(end_pos_str[0])
        x = 8 - end_pos_str[1].to_i
        return [x, y]
    end

    def get_moving_piece(move, color)
        piece_char = get_piece_char(move)
        end_pos = get_end_pos(move)
        possible_pieces = [*get_moving_pieces(piece_char, color)]
        possible_pieces.select! {|piece| piece.valid_move?(end_pos)}
        if possible_pieces.length > 1
            piece_col_idx = piece_char == "P" ? 0 : 1
            y = ('a'..'h').to_a.index(move[piece_col_idx])
            if y
                possible_pieces.select! {|piece| piece.pos[1] == y}
            else 
                x = ('1'..'8').to_a.index(move[1])
                possible_pieces.select! {|piece| piece.pos[0] == x}
            end
        end


        raise 'move not found' if possible_pieces.length == 0
        return possible_pieces[0]
    end

    def get_moving_pieces(piece_char, color)
        if color == :white
            case piece_char
            when 'P' then return @white_pawns
            when 'K' then return [@white_king]
            when 'Q' then return [@white_queen]
            when 'R' then return @white_rooks
            when 'N' then return @white_knights
            when 'B' then return @white_bishops
            else raise 'invalid input, piece not found'
            end
        else
            case piece_char
            when 'P' then return @black_pawns
            when 'K' then return [@black_king]
            when 'Q' then return [@black_queen]
            when 'R' then return @black_rooks
            when 'N' then return @black_knights
            when 'B' then return @black_bishops
            else raise 'invalid input, piece not found'
            end
        end
    end

    def make_move(move, color)
        return castle(move, color) if move[0..2] == "O-O"
        piece = get_moving_piece(move, color)
        x, y = piece.pos
        raise "no piece there" if rows[x][y].empty?
        end_pos = get_end_pos(move)
        end_x, end_y = end_pos
        @en_passant = nil;
        if (piece.is_pawn? && piece.at_start_row? && (end_x - x).abs == 2)
            @en_passant = [(x + end_x) / 2, end_y]
        elsif piece.is_king?
            cancel_castle(color)
        end
        rows[end_x][end_y] = piece
        piece.pos = end_pos
        rows[x][y] = sentinel
    end

    def cancel_castle(color)
        rooks = color == :white ? @white_rooks : @black_rooks
        rooks.each {|rook| rook.can_castle = false}
    end

    def is_en_passant?(pos)
        pos == @en_passant
    end

    def to_FEN(cur_color)
        fen = []
        fen_rows = []
        rows.each do |row|
            row_fen = []
            row.each do |piece|
                piece_fen = piece.fen
                if piece_fen
                    row_fen << piece_fen
                elsif row_fen.last.is_a? Integer
                    row_fen[row_fen.length - 1] += 1
                else
                    row_fen << 1
                end
            end
            fen_rows << row_fen.join('')
        end

        fen << fen_rows.join('/')
        fen << cur_color[0]
        fen << castle_fen
        fen << en_passant_fen
        fen.join(' ')
    end

    def en_passant_fen
        return '-' if !@en_passant
        ('a'..'h').to_a[@en_passant[1]] + (8 - @en_passant[0]).to_s
    end

    def castle_fen
       fen = ''
       fen += 'K' if @white_kingside_rook.can_castle
       fen += 'Q' if @white_queenside_rook.can_castle
       fen += 'k' if @black_kingside_rook.can_castle
       fen += 'q' if @black_queenside_rook.can_castle
       fen = '-' if fen.length == 0
       fen
    end

    def castle(move, color)
        cancel_castle(color)
        is_queen_side = move[0..4] == "O-O-O"

        row = color == :white ? 7 : 0

        king_start_col = 4
        king_end_col = is_queen_side ? 2 : 6
        king_start_pos = [row, king_start_col]
        king_end_pos = [row, king_end_col]
        

        rook_start_col = is_queen_side ? 0 : 7
        rook_end_col = is_queen_side ? 3 : 5
        rook_start_pos = [row, rook_start_col]
        rook_end_pos = [row, rook_end_col]

        p king_start_pos
        p king_end_pos
        p rook_start_pos
        p rook_end_pos
        move_piece!(color, king_start_pos, king_end_pos, true)
        move_piece!(color, rook_start_pos, rook_end_pos, true)
    end

    def move_piece!(color, start_pos, end_pos, castle = false)
        x, y = start_pos
        piece = rows[x][y]
        end_x, end_y = end_pos
        rows[end_x][end_y] = piece
        piece.pos = end_pos
        rows[x][y] = sentinel
    end

    def in_check?(color)
        king_pos = find_king(color)
        opp_color = (color == :white ? :black : :white)
        @rows.flatten.any? {|piece| piece.color == opp_color && piece.moves.include?(king_pos)}
    end

    def checkmate?(color)
        in_check?(color) && @rows.flatten.none? {|piece| piece.color == color && !piece.valid_moves.empty?}
    end

    def find_king(color)
        i = 0
        @rows.flatten.each_with_index {|piece, j| i = j if (piece.symbol == ' ♚ '.colorize(color))}
        [i / 8, i % 8]
    end

    def valid_pos?(pos)
        pos.all? {|coord| coord.between?(0,7)}
    end

    def [](pos)
        x, y = pos
        @rows[x][y]
    end

    def []=(pos, val)
        @rows[x][y] = val
    end

    def dup
        dup_board = Board.new(@rows.dup)
        dup_board.rows.each_with_index do |row, x|
            new_row = []
            row.each_with_index do |piece, y|
                if piece.empty?
                    new_row << piece
                else
                    new_piece = piece.dup
                    new_piece.board = dup_board
                    new_piece.pos = [x, y]
                    new_row << new_piece
                end
            end
            dup_board.reassign_row(x, new_row)
        end            
        dup_board
    end

    protected
    def reassign_row(i, new_row)
        @rows[i] = new_row
    end
end

