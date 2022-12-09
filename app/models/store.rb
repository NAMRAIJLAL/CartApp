class Store < ApplicationRecord
    validates :name, presence: false, 
        length: {minimun:5, maximum: 15 }
    belongs_to :user, optional: true
end
