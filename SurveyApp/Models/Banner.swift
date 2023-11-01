//
//  Banner.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation
import SwiftUI

enum BannerType {
    case Success
    case Error
}

struct BannerData {
    let title: String
    let detail: String
    let type: BannerType
    let color: Color
    
    init(type: BannerType) {
        self.type = type
        if type == .Success {
            title = "Success"
            detail = "Your answer was submitted successfully."
            color = .green
        } else {
            title = "Error"
            detail = "Oops! Something went wrong. Please try again!"
            color = .red
        }
    }
}
