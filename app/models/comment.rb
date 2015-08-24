class Comment < ActiveRecord::Base
  validates :body, :author_id, :commentable_type, :commentable_id, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :author,
    class_name: 'User'
end
