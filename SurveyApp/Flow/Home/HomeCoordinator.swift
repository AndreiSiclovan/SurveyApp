//
//  HomeCoordinator.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import SwiftUI

struct HomeCoordinator: View {
    
    @State private var destination: Destinations? = nil

    private enum Destinations {
        case questions
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                NavigationLink(destination: questionsView, tag: Destinations.questions, selection: $destination) { EmptyView() }
                
                HomeView() {
                    destination = .questions
                }
            }
        }
    }
    
    private var questionsView: some View {
        QuestionsView(viewModel: .init())
    }
}

