class Comment < ApplicationRecord
  validates :text, presence: true

  belongs_to :ticket
  belongs_to :author, class_name: "User"
  belongs_to :state, optional: true
  after_create :set_ticket_state

  scope :persisted, -> { where.not(id: nil) }
  scope :ordered, -> { order(created_at: :asc) }

  private
  def set_ticket_state
    ticket.state = state
    ticket.save!
  end
end
