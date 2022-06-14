class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :active, lambda { where(archived_at: nil) }

  def show_admin_status
    # "#{email} (#{admin? ? 'Admin' : 'User'})"
    "#{email} - #{is_admin_to_s} #{active_status}"
    # email
    # admin_to_s
  end

  def is_admin_to_s
    "#{admin? ? 'Admin' : 'User'}"
  end

  def active_status
    "#{archived_at ? 'Archived' : 'Active'}"
  end

  def archive!
    self.update(archived_at: Time.now)
  end

  def active_for_authentication?
    super && archived_at.nil?
  end

  def inactive_message
    archived_at.nil? ? super : :archived
  end
end
