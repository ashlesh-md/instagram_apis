class NotificationService
    def self.send_notification(user_id, message)
      Notification.create(user_id: user_id, message: message, read_status: false)
    end
  end
  