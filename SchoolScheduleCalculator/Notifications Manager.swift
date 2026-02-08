import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}
    
    var isDay1: Bool {
        let dayOfMonth = Calendar.current.component(.day, from: Date())
        return dayOfMonth % 2 == 1
    }
    
    let weekdays = [2, 3, 4, 5, 6]
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            } else {
                print("Permission granted: \(granted)")
            }
        }
    }
    
    func scheduleMorningNotification(
        class1Title: String,
        class1Room: String,
        class2Title: String,
        class2Room: String
    ) {
        // 1. Decide which class is first today
        let firstTitle = isDay1 ? class1Title : class2Title
        let firstRoom  = isDay1 ? class1Room  : class2Room
        
        // 2. Build the notification content
        let content = UNMutableNotificationContent()
        content.title = "First class today:"
        content.body = "\(firstTitle) in room \(firstRoom)"
        content.sound = .default
        
        // 3. Time: 8:45 AM
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 45
        
        for weekday in weekdays {
            var components = dateComponents
            components.weekday = weekday
            
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )
            
            let request = UNNotificationRequest(
                identifier: "morning-\(weekday)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func schedulePeriod2Notification(
        class1Title: String,
        class1Room: String,
        class2Title: String,
        class2Room: String
    ) {
        let secondTitle = isDay1 ? class2Title : class1Title
        let secondRoom  = isDay1 ? class2Room  : class1Room
        
        let content = UNMutableNotificationContent()
        content.title = "Next class:"
        content.body = "\(secondTitle) in room \(secondRoom)"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 10
        
        for weekday in weekdays {
            var components = dateComponents
            components.weekday = weekday
            
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )
            
            let request = UNNotificationRequest(
                identifier: "period2-\(weekday)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
        
    }
    
    func schedulePeriod3Notification(
        class3Title: String,
        class3Room: String,
        class4Title: String,
        class4Room: String
    ) {
        let thirdTitle = isDay1 ? class3Title : class4Title
        let thirdRoom  = isDay1 ? class3Room  : class4Room
        
        let content = UNMutableNotificationContent()
        content.title = "Next class:"
        content.body = "\(thirdTitle) in room \(thirdRoom)"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 28
        
        for weekday in weekdays {
            var components = dateComponents
            components.weekday = weekday
            
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )
            
            let request = UNNotificationRequest(
                identifier: "period3-\(weekday)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
        
    }
    
    
    func schedulePeriod4Notification(
        class3Title: String,
        class3Room: String,
        class4Title: String,
        class4Room: String
    ) {
        let fourthTitle = isDay1 ? class4Title : class3Title
        let fourthRoom  = isDay1 ? class4Room  : class3Room
        
        let content = UNMutableNotificationContent()
        content.title = "Last Class For Today:"
        content.body = "\(fourthTitle) in room \(fourthRoom)"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 13
        dateComponents.minute = 46
        
        for weekday in weekdays {
            var components = dateComponents
            components.weekday = weekday
            
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )
            
            let request = UNNotificationRequest(
                identifier: "period4-\(weekday)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test to confirm notifications are working."

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
    
}
