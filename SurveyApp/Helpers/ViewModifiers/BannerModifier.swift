//
//  Banner.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import SwiftUI

struct BannerModifier<T: View>: ViewModifier {
    
    @Binding var show: Bool
    let bannerView: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                bannerView
            }
        }
    }
}

