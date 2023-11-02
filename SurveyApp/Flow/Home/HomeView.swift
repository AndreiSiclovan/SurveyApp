//
//  HomeView.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    var startSurvey: () -> Void
    
    var body: some View {
        VStack {
            Button(action: startSurvey) {
                
                VStack {
                    Text("Start Survey")
                        .foregroundColor(.black)
                }
                .padding()
                
            }
            .accessibilityIdentifier("startSurvey")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(startSurvey: {})
    }
}
