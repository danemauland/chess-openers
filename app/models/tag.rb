class Tag < ApplicationRecord
    validates :tag, presence: true, uniqueness: true

    has_many :move_tags
    has_many :moves, through: :move_tags, source: :move
end
