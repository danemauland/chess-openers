class Line < ApplicationRecord
    validates :line, presence: true, uniqueness: true

    has_many :move_lines
    has_many :moves, through: :move_lines, source: :move
end
