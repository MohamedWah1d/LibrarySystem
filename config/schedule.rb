every 1.day, at: '12:00 am' do
    runner "OverdueNotificationJob.perform_now"
  end
  
  every 1.day, at: '12:00 am' do
    runner "UpcomingDueDateNotificationJob.perform_now"
  end