class MoveLine < ApplicationRecord
    validates :move_id, :line_id, presence: true
    validates :move_id, uniqueness: {scope: :line_id}

    belongs_to :move
    belongs_to :line
end
