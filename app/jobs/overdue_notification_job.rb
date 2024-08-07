class OverdueNotificationJob < ApplicationJob
  queue_as :default

  def perform
    overdue_requests = BorrowRequest.where("intended_return_date < ? AND return_date IS NULL", Time.current)
    admins = User.where(admin: true)

    overdue_requests.each do |request|
      NotificationMailer.overdue_book_notification(request.user, request.book).deliver_now
      admins.each do |admin|
        NotificationMailer.admin_overdue_notification(admin, request.book).deliver_now
      end
    end
  end
end
