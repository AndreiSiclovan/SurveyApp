//
//  Extensions+View.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import SwiftUI

extension View {
    func bannerOverlay<T: View>(bannerView: T, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier.init(show: show, bannerView: bannerView))
    }
}
