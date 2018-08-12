class Contributor < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: { allow_blank: true }
end
