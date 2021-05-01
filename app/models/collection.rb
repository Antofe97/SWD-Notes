class Collection < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :nullify
end
