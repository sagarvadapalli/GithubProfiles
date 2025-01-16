//
//  Date+Extensions.swift
//  FetchRewardsCodingExercise
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import Foundation

extension Date {
  func toLocalString() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MM-dd-yyyy HH:mm a"
    dateFormatter.timeZone = .current
    return dateFormatter.string(from: self)
  }
}
