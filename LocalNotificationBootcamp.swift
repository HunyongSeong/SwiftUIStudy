//
//  LocalNotificationBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/05.
//
// 스위프트 유아이와 관련하여 응용 프로그램을 만드는 경우 중요한 로컬 알림에 대해서 알아보겠습니다.
// 로컬알림의 예는 매주 월요일 5시 알람. 실제로 우리가 설정해서 사용하는 알람이라고 볼 수 있음.
// 인스타그램처럼 내 사진에 좋아요를 누르고 나한테 알림이 뜨는 경우에는 서버가 필요함

// 첫 번째는 시간 알람
// 두 번쨰는 날짜 알람
// 실제 위치를 사용하는 알람: 사용자가 물리적 위치에 들어가거나 나갈 때 알림이 발생하도록 예약할 수 있음.
import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager() // 싱글톤: 모든 알림 요청을 관리할 클래스를 만들기 위해 싱글톤을 만듬
  
    func requestAuthorization() { // 앱을 사용할 때 알림 권한을 요청
        let options: UNAuthorizationOptions = [.alert, .sound, .badge] // 알람, 소리, 배지
        
        // 위에서 정의한 options을 아래로 전달 -> (options: options)
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error { // 만약 오류가 있다면, 방금 얻은 오류를 출력
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was soooooo easy!"
        content.sound = .default
        content.badge = 10000 // 아이콘 옆에 뜰 배지
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 11
//        dateComponents.minute = 27
//        dateComponents.weekday = 6 // 일(1), 월, 화, 수, 목, 금, 토(7)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        let coordicates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordicates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        // import CoreLocation 해주면 (region: , repeats: )을 사용할 수 있다.
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") { // 버튼 클릭시, 권한 요청
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0 // 앱이 다시 빌드가 되면, 배지 숫자가 0이 됨
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
