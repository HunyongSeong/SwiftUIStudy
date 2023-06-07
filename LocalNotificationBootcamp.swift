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
    func scheduleNotification() { // 스케줄 알람
        
        let content = UNMutableNotificationContent() // 변경할 수 없는 알림
        content.title = "This is my first notification!" //title
        content.subtitle = "This was soooooo easy!" //subtitle
        content.sound = .default // sound
        content.badge = 10000 // badge == 앱 아이콘 옆에 뜰 배지
        
        // time trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false) // 시간의 간격을 이용한 알림
        //(timeInterval: 5.0, repeats: false) // (시간 간격, 반복)
        // 일정을 잡은 후 5초가 지나면 해당 트리거를 가져와 아래의 let request에 전달한다.(앱을 나갔을 경우)
        
//        // calendar trigger
//        var dateComponents = DateComponents() // 비어있는 날짜 생성
//        dateComponents.hour = 11 // 시간 추가
//        dateComponents.minute = 27 // 분 추가
//        dateComponents.weekday = 6 // 요일 추가 / 일(1), 월, 화, 수, 목, 금, 토(7)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) // 일정을 이용한 알림 / 설정을 통하여 매주 매일 알림을 줄 수 있음
        
//        // location trigger
//        let coordicates = CLLocationCoordinate2D( // coordicates: 좌표 <- 이곳에서 좌료를 설정
//            latitude: 40.00, // 위도
//            longitude: 50.00) // 경도
//
//        let region = CLCircularRegion( // 중심점 주위에 반경이 100 미터인 영역을 추가 후 사용자가 해당역엑에 들어갈 때, 나갈 때 알림을 줄 수 있음
//            center: coordicates, // 중심
//            radius: 100,        // 반지름: 중심점에서 가장자리까지 미터 단위로 측정 됨
//            identifier: UUID().uuidString) // 우리 목적에 대한 식별자는 관련이 없기 때문에(?) 임의의 ID 사용
//        region.notifyOnEntry = true // 진입 시 알림
//        region.notifyOnExit = false // 퇴장 시 알림
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true) // 위치를 이용한 알림
//        // import CoreLocation 해주면 (region: , repeats: )을 사용할 수 있다.
        
        // request ============================
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, // 이 identifier와 그냥 region의 identify는 무슨 차이가 있을까?
            content: content,
            trigger: trigger) // time, calendar, locagion / 설정한 트리거에 맞게 요청
        // request ============================
        UNUserNotificationCenter.current().add(request) // 설정한 알림 요청을 마지막에 호출
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 예약된 알림 메세지 제거
        UNUserNotificationCenter.current().removeAllDeliveredNotifications() // 받은 알림들 제거(알림함에 쌓여있는 알림)
    }
    
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") { // 버튼 클릭시, 권한 요청
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") { // 일정 알림 만들기
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") { // 취소 알림
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0 // 앱이 다시 빌드가 되면, 배지 숫자가 0으로 변경
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
