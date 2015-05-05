class Message < ActiveRecord::Base
  belongs_to :user
  defaut_scopt -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length { maximum: 250 }
end
