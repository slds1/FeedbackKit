// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import SwiftUI

enum FeedbackType {
    case light
    case medium
    case hard
    case custom(Int)
}

struct FeedbackModifier: ViewModifier {
    @Binding var trigger: Bool
    var type: FeedbackType
    var hapticValue: Int?

    func body(content: Content) -> some View {
        content
            .onChange(of: trigger) { newValue in
                if newValue {
                    provideFeedback(for: type, hapticValue: hapticValue)
                    trigger = false
                }
            }
    }

    private func provideFeedback(for type: FeedbackType, hapticValue: Int?) {
        let generator: UIImpactFeedbackGenerator
        
        switch type {
        case .light:
            generator = UIImpactFeedbackGenerator(style: .light)
        case .medium:
            generator = UIImpactFeedbackGenerator(style: .medium)
        case .hard:
            generator = UIImpactFeedbackGenerator(style: .heavy)
        case .custom(let intensity):
            if let hapticValue = hapticValue {
                let customGenerator = UIImpactFeedbackGenerator(style: intensityForValue(hapticValue))
                customGenerator.impactOccurred()
            }
            return
        }
        
        generator.impactOccurred()
    }

    private func intensityForValue(_ value: Int) -> UIImpactFeedbackGenerator.FeedbackStyle {
        switch value {
        case 1:
            return .light
        case 2:
            return .medium
        default:
            return .heavy
        }
    }
}

extension View {
    func feedback(trigger: Binding<Bool>, type: FeedbackType = .hard, haptic: Int? = nil) -> some View {
        self.modifier(FeedbackModifier(trigger: trigger, type: type, hapticValue: haptic))
    }
}

