import Foundation

// 날짜 정보를 담을 구조체
struct DateInfo: Identifiable {
    let id = UUID()
    let day: Int     // 요일 (1: 일요일 ~ 7: 토요일)
    let date: Int    // 일자
}

class DateManager {
    private let calendar = Calendar.current
    private let today = Date()
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    // MARK: - 오늘 날짜 가져오기 (년,월,일 각각)
    var currentYear: Int {
        return calendar.component(.year, from: today)
    }
    
    var currentMonth: Int {
        return calendar.component(.month, from: today)
    }
    
    var currentDay: Int {
        return calendar.component(.day, from: today)
    }
    
    var currentWeekday: Int {
        return calendar.component(.weekday, from: today)
    }
    
    // MARK: - 오늘 날짜 문자열로 가져오기
    func getCurrentDate(format: String = "yyyy-MM-dd") -> String {
        formatter.dateFormat = format
        return formatter.string(from: today)
    }
    
    // 다양한 포맷 예시 메서드들
    func getCurrentDateFull() -> String {
        return getCurrentDate(format: "yyyy-MM-dd HH:mm:ss")
    }
    
    func getCurrentDateKorean() -> String {
        return getCurrentDate(format: "yyyy년 MM월 dd일")
    }
    
    func getCurrentDateCompact() -> String {
        return getCurrentDate(format: "yyyyMMdd")
    }
    
    // MARK: - 날짜 범위 계산
    func getDateRange(offsetDays: Int = 3) -> [DateInfo] {
        var dateArray: [DateInfo] = []
        
        // -offsetDays부터 +offsetDays까지 순회
        for dayOffset in -offsetDays...offsetDays {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: today) {
                let weekday = calendar.component(.weekday, from: date)
                let dayOfMonth = calendar.component(.day, from: date)
                
                let dateInfo = DateInfo(day: weekday, date: dayOfMonth)
                dateArray.append(dateInfo)
            }
        }
        
        return dateArray
    }
    
    // MARK: - 유틸리티 메서드
    func weekdayString(from weekday: Int) -> String {
        let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
        return weekdays[weekday - 1]
    }
}
