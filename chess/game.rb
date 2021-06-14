require_relative "board"

class Game

    def initialize(opening, color)
        @board = Board.new
        @display = Display.new(@board)
        @human_color = color
        @is_humans_turn = @human_color == :white
        @computer_color = @is_humans_turn ? :black : :white
        @current_move = opening

    end


    def get_move
        move = nil
        until move
            @display.render
            puts 'enter a move'
            move = gets.chomp
            if @current_move.children.keys.none? {|child| child == move}
                move = nil
                puts 'move not part of opening'
            end
        end
        move
    rescue => e
        puts e.message
        retry
    end

    def play
        puts
        while @current_move
            if @is_humans_turn
                @current_move = @current_move.children[get_move]
                system("clear")
                puts @current_move.val
                # @current_player.make_move(@board)
                # switch_players
            else
                @current_move = @current_move.children.values.sample
                puts @current_move.val
            end
            @board.make_move(@current_move.val, @is_humans_turn ? @human_color : @computer_color)
            @is_humans_turn = !@is_humans_turn
        end
    end
end