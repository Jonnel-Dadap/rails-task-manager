class Task < ApplicationRecord
  enum :status, {
    pending: "Pending",
    in_progress: "In Progress",
    completed: "Completed"
  }
  before_validation :set_default_status, on: :create # callback
  before_validation :set_normalize_title
  validate :must_be_completed_to_archive, if: :archived?

  validates :title, presence: true
  validates :description, presence: true


  private

  def set_default_status
    self.status ||= "Pending"
  end

  def  set_normalize_title
    self.title = title.strip if  title.present?
  end
  def must_be_completed_to_archive
     errors.add(:archived, "can only be archived when the task is completed") unless completed?
  end
end
