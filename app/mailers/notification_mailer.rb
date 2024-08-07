class NotificationMailer < ApplicationMailer
    default from: 'notifications@library.com'

    def overdue_book_notification(user, book)
      @user = user
      @book = book
      mail(to: @user.email, subject: 'Overdue Book Notification')
    end 

    def upcoming_due_date_notification(user, book)
      @user = user
      @book = book
      mail(to: @user.email, subject: 'Upcoming Due Date Reminder')
    end 
    
    def admin_overdue_notification(admin, book)
      @admin = admin
      @book = book
      mail(to: @admin.email, subject: 'Overdue Book Alert')
    end
end
