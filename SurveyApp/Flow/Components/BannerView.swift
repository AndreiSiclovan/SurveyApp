//
//  BannerView.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import SwiftUI

struct BannerView: View {
    let data: BannerData
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(data.title)
                    .bold()
                Text(data.detail)
                    .font(.system(size: 15))
                
            }
            .foregroundColor(.black)
            .padding(12)
            .background(data.color)
            .cornerRadius(8)
            Spacer()
        }
        .padding()
        .animation(.easeInOut)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onTapGesture {
            withAnimation {
                self.show = false
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.show = false
                }
            }
        })
    }
}

