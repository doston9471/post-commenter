class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_secure_password

  after_commit :broadcast_changes

  def broadcast_changes
    if online_previously_changed?
      Turbo::StreamsChannel.broadcast_refresh_to(:presence)
    end
  end

  def came_online
    update!(online: true) unless online?
  end

  def went_offline
    update!(online: false) if online?
  end
end
