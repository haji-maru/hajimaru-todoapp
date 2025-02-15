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
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
class Task < ApplicationRecord
  validates :title, presence: true
  validates :title, format: { without: /\A[!@#]/ }

  validates :content, presence: true
  validates :content, uniqueness: true

  validates :due_date, presence: true

  belongs_to :user
end
