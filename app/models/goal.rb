class Goal < ActiveRecord::Base
  validates :title, :user_id, :privacy, :cheers_value, presence: true
  validates :privacy, inclusion: { in: %w(Private Public),
    message: "must be either Public or Private" }
  validates :completed, inclusion: { in: [true, false],
    message: "must be either true or false" }

  belongs_to :user
  include Commentable
end
