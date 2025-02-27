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

  def unique_commenters
    displayed_users = [] # user_idの格納用
    unique_users = [] # uniqなuser_idの格納用

    comments.each do |comment|
      unless displayed_users.include?(comment.user.id) # 重複チェック
        displayed_users << comment.user.id # user_idを格納
        unique_users << comment.user  # userを格納
      end
    end

    unique_users  # 最終的に格納したuserを返す
  end
end
