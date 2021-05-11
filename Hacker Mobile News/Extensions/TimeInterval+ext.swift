//
//  TimeInterval+ext.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 08-05-21.
//

import Foundation

extension TimeInterval {
    func secondsToDaysHoursMinutesSeconds () -> (Int, Int, Int, Int) {
        return (Int(self) / 86400, (Int(self) % 86400) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }
}
