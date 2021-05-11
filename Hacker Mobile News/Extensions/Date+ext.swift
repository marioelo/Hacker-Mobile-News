//
//  Date+ext.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 10-05-21.
//

import Foundation

extension Date {
    
    func timeAgoString() -> String {
        var returningString = ""
        let intervalSinceCreation = Date().timeIntervalSince(self)
        let (days, hours, minutes, _) = intervalSinceCreation.secondsToDaysHoursMinutesSeconds()
        if days > 0 { returningString += "\(days)d " }
        if hours > 0 { returningString += "\(hours)h " }
        if minutes > 0 { returningString += "\(minutes)m" }
        return returningString
    }
}
