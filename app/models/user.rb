class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :email
    has_many :notes, dependent: :destroy
    has_many :collections, dependent: :destroy
end
