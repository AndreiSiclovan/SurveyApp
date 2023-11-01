//
//  HomeCoordinator.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import SwiftUI

struct HomeCoordinator: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                addTransactionView
            }
        }
    }
}

