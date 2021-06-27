class MoveTag < ApplicationRecord
    validates :move_id, :tag_id, presence: true
    validates :move_id, uniqueness: {scope: :tag_id}

    belongs_to :move
    belongs_to :tag
end
