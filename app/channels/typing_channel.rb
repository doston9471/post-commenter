class TypingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "typing"
  end

  def typing
    ActionCable.server.broadcast("typing", { action: "typing", uid: current_user.id.to_s, user_email: current_user.email })
  end

  def typing_stopped
    ActionCable.server.broadcast("typing", { action: "typing_stopped", uid: current_user.id.to_s, user_email: current_user.email })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
