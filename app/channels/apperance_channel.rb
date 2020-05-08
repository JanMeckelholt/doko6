class ApperanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    current_player.appear
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_player.disappear
  end

  def appear
    current_player.appear(on: data['appearing_on'])
  end

  def away
    current_player.away
  end
end
