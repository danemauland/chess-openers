class Fen < ApplicationRecord
    validates :fen, presence: true, uniqueness: true

    has_many :moves, foreign_key: :prev_fen_id

    def random_next_move(params)
        Move.random_move(params, id)
    end
end
