# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  due_date   :datetime         not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
class Task < ApplicationRecord
  has_one_attached :eyecatch

  validates :title, presence: true
  validates :title, format: { without: /\A[!@#]/ }

  validates :content, presence: true
  validates :content, uniqueness: true

  validates :due_date, presence: true

  belongs_to :user
  belongs_to :board

  has_many :comments, dependent: :destroy

  def comment_count
    comments.count
  end
end
