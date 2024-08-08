class NotificationMailer < ApplicationMailer
  default from: 'notifications@library.com'

  def overdue_book_notification(user, book)
    @user = user
    @book = book
    mail(to: @user.email, subject: 'Overdue Book Notification') do |format|
      format.text { render plain: overdue_book_notification_text }
    end
  end

  def upcoming_due_date_notification(user, book)
    @user = user
    @book = book
    mail(to: @user.email, subject: 'Upcoming Due Date Reminder') do |format|
      format.text { render plain: upcoming_due_date_notification_text }
    end
  end

  def admin_overdue_notification(admin, book)
    @admin = admin
    @book = book
    mail(to: @admin.email, subject: 'Overdue Book Alert') do |format|
      format.text { render plain: admin_overdue_notification_text }
    end
  end

  private

  def overdue_book_notification_text
    <<-TEXT
    Dear #{@user.name},

    The following book is overdue:

    Title: #{@book.title}
    Author: #{@book.author}

    Please return it as soon as possible.

    Thank you,
    Your Library Team
    TEXT
  end

  def upcoming_due_date_notification_text
    <<-TEXT
    Dear #{@user.name},

    This is a reminder that the following book is due soon:

    Title: #{@book.title}
    Author: #{@book.author}

    Please ensure it is returned by the due date.

    Thank you,
    Your Library Team
    TEXT
  end

  def admin_overdue_notification_text
    <<-TEXT
    Dear #{@admin.email},

    The following book is overdue:

    Title: #{@book.title}
    Author: #{@book.author}

    Please take appropriate action.

    Thank you,
    Your Library Team
    TEXT
  end
end
