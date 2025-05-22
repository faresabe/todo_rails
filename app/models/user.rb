class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, length: {minimum:3, maximum:10} if: -> {new_record? || !password.nil? }
    has_many :tasks, dependent: :destroy
end
