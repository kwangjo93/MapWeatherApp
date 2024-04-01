//
//  UIView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/1/24.
//

import SwiftUI

extension View {
    var topSafeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
}
