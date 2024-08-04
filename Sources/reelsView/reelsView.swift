// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

// Parent class integrating the framework with init
@available(iOS 13, *)
open class reelsView {
    public static func createReelsView(frame: CGRect, videos: [Any]) -> Reels {
        return Reels(frame: frame, videoNames: videos)
    }
}
