class PresenceChannel < ApplicationCable::Channel
  extend Turbo::Streams::Broadcasts, Turbo::Streams::StreamName
  include Turbo::Streams::StreamName::ClassMethods

  def subscribed
    stream_from "presence"
    current_user.came_online
  end

  def unsubscribed
    current_user.went_offline
  end
end
