class Note < ApplicationRecord
    validates :body, presence: true
    belongs_to :user
    has_many :collections
end
