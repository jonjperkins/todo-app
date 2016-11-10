class Item < ApplicationRecord
  belongs_to :list
  validates :content, presence: true
  validates :list_id, presence: true

  def completed?
    !completed_at.blank?
  end
end
