class Move < ApplicationRecord
    validates :move, :prev_fen_id, :next_fen_id, presence: true
    validates :move, uniqueness: {scope: :prev_fen_id}

    has_many :move_tags
    has_many :tags, through: :move_tags, source: :tag
    has_many :comments
    has_many :move_lines
    has_many :lines, through: :move_lines, source: :line
    belongs_to :fen, foreign_key: :next_fen_id

    def self.random_move(params, fen_id)
        self.includes(:comments, :lines, :tags, :fen)
            .where(prev_fen_id: fen_id)
            .where('tags.tag': params[:tags])
            .where('lines.line': params[:lines])
            .sample
    end
end
