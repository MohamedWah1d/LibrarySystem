class UpcomingDueDateNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    upcoming_requests = BorrowRequest.where("intended_return_date = ?", 1.day.from_now.to_date)
    
    upcoming_requests.each do |request|
      NotificationMailer.upcoming_due_date_notification(request.user, request.book).deliver_now
    end
  end
end
