class NotifySubscribersJob < ApplicationJob
  queue_as :default
  def perform(post_id)
  end
end
