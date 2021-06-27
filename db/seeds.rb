# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Fen.create(fen: :abc)
Fen.create(fen: :xyz)
Move.create(move: 'a', prev_fen_id: 1, next_fen_id: 2)
Tag.create(tag: 'mainline')
Line.create(line: 'Vienna Gambit')
MoveLine.create(move_id: 1, line_id: 1)
MoveTag.create(move_id: 1, tag_id: 1)