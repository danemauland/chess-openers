require_relative 'node'
require_relative 'game'

vienna_gambit = "e4 e5 Ke2 Qe7 Nf3 d6 O-O Bd7 Re1 Nc6 d3 O-O-O"
# vienna_gambit = "e4 e5 Be2 Qe7 Nf3 d6 O-O Bd7 Re1 Nc6 d3 O-O-O"
# vienna_gambit = "1. e4 e5 2. Nc3 Nf6 3. f4 d5 4. fxe5 Nxe4 5. Qf3 Nxc3 (5... { tag: sideline } Nc6 { A tricky and challenging move. We must prevent Nxe5. } 6. Bb5 Nxc3 (6... { tag: sideline } f5 { Combining Nc6 with f5 makes no sense.  } 7. d3 Nxc3 8. bxc3 Be6 9. Ne2) 7. dxc3 Qh4+ (7... { tag: sideline } a6 8. Bxc6+ bxc6 9. Ne2 {  And we prepare castling with Nd4 coming. Natural development here can quickly backfire for Black. } Bc5 10. Qg3 Rg8 11. Bg5 Be7 12. Bxe7 Qxe7 13. O-O) (7... { tag: sideline } Be7 8. Ne2) 8. g3 Qe4+ 9. Be3 { Don't rush to trade queens. We prefer if Black will take our queen first, and if Black gets greedy with Qxe5... { tag: sideline } } Qxe5 (9... { tag: sideline } Qxf3 10. Nxf3 { [%cal Ge1c1] }) (9... { tag: sideline } Qxc2 10. Ne2 { and now Black has to come back and offer the trade again, as taking on b2 leads to us castling with a huge attack. } Qe4 11. Qxe4 dxe4 12. Nd4 Bd7 13. Nxc6 bxc6 14. Ba4 { Down a pawn for the moment but with the amount of weaknesses (c6, c7, e4, f7) we'll continue pressure throughout the middlegame. }) 10. O-O-O Be6 11. Ne2 { We've sacrificed a pawn for an initiative. Our ideas include Nd4/f4, or Bf4, and moving the Rh1 to f1 or e1. }) (5... { tag: sideline } f5 { I'll be very clear: this is the best move in my experience, but we will try to mix things up here regardless. } 6. d3 (6. Nh3 { You can also try this tricky line, and I actually recommend it over the standard d3 line. } Nc6 7. d3 Nxc3 8. bxc3 { Gambiting e5. } Nxe5 9. Qe2 {  [%cal Gd3d4] } Qe7 (9... { tag: sideline } Qh4+ 10. g3 Qe7 11. Bg2 Ng6 12. Be3) 10. Bg5) 6... { tag: sideline } Nxc3 7. bxc3 { Now if Black doesn't play the critical d5-d4, we will get a very easy game. } d4 (7... { tag: sideline } Be7 8. Ne2 { [%csl Rd4] } O-O 9. g3) 8. Qg3 { Remember this move! You're freeing up f3 for the knight and preventing the Bf8 from moving. } Nc6 9. Be2 { Another important moment -- we must develop Be2 before moving our knight, as we threaten Bh5+ here. } Be6 10. Bf3 Qd7 11. Ne2 dxc3 12. Be3 Nb4 13. Rc1 Nd5 14. Bxd5) 6. bxc3 Be7 (6... { tag: sideline } Qh4+ 7. g3 Qe4+ 8. Qxe4 dxe4 9. Bg2 (9. d4 exd3 10. cxd3 Nc6 11. d4) 9... { tag: sideline } Nc6 10. Bxe4 Nxe5 11. Rb1 c6 12. d4 Nc4 13. Nf3 Bd6 14. Kf2 O-O 15. Bd3 Nb6 16. c4) (6... { tag: sideline } c5 7. Qg3 { A good way to put Black's development on hold as usual. } Nc6 8. Nf3 Bf5 9. Bd3 Bxd3 10. cxd3 g6 11. O-O Bg7 12. d4 cxd4 13. Nxd4 Nxd4 14. cxd4 O-O 15. Ba3 Re8 16. Qb3) (6... { tag: sideline } Be6 7. Nh3) 7. d4 c5 8. Bd3 cxd4 (8... { tag: sideline } Nc6 9. Ne2 Be6 10. O-O Qd7 11. Qg3 O-O-O 12. Bb5 a6 13. Bxc6 Qxc6 14. Bg5 Bxg5 15. Qxg5 cxd4 16. cxd4 Kb8 17. c3) 9. cxd4 Qa5+ 10. Bd2 Bb4 11. Rd1 Bxd2+ 12. Rxd2 Nc6 13. Ne2 Nb4 14. O-O O-O 15. Ng3 Qb6 { Perelshteyn-Gledura (2018) and now an improvement is } 16. Bf5 { With ideas of c2-c3, Qg4 and a kingside attack. }"
# e4 Nc3 f4 fxe5 Qf3
def create_opening_node(pgn)
    pgn.gsub! /\s\{\s(?!tag).*?\}/, ''
    pgn.gsub! '(', '( '
    pgn.gsub! ')', ' )'
    pgn.gsub! /\d+\.{1,3}\s/, ''

    variations, current_node, tagging, tag, root_node = [], nil, false, nil, nil

    pgn.split(' ').each_with_index do |move, i|
        case move
        when '('
            variations.push(current_node)
            current_node = current_node.parent
        when ')' then current_node = variations.pop
        when '{' then 'do nothing'
        when 'tag:' then tagging = true
        when '}' then tagging = false
        else
            if tagging && !tag
                tag = move[0..-1]
            else
                node = Node.new(move, tag)
                if !root_node
                    root_node = node
                else
                    current_node.add_child_node(node)
                end
                current_node = node
                tag = nil
            end
        end
    end

    root_node
end

def create_root_node(nodes)
    root = Node.new(nil, nil)
    nodes.each {|node| root.add_child_node(node)}
    root
end

opening_nodes = [create_opening_node(vienna_gambit)]
root_node = create_root_node(opening_nodes)

Game.new(root_node, :white).play