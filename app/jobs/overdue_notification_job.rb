class OverdueNotificationJob < ApplicationJob
  queue_as :default

  def perform
    overdue_requests = BorrowRequest.where('intended_return_date < ? AND return_date IS NULL', Time.current)
    overdue_requests.each do |request|
      NotificationMailer.overdue_book_notification(request.user, request.book).deliver_now
    end

    admins = User.where(user_type: :admin)
    overdue_requests.each do |request|
      admins.each do |admin|
        NotificationMailer.admin_overdue_notification(admin, request.book).deliver_now
      end
    end
  end
end
