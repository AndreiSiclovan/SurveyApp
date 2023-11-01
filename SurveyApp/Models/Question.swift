//
//  Question.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation

struct Question: Codable {
    let id: Int
    let question: String
    var answer: Answer?
}
