class Comment < ApplicationRecord
    validates :comment, :move_id, presence: true

    belongs_to :move
end
