//
//  String+Extensions.swift
//  FetchRewardsCodingExercise
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import Foundation

extension String {
  func toDate(with format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.date(from: self)
  }
}
