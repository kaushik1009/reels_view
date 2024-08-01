// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

public class reelsView {
    public static func createReelsView(frame: CGRect, videos: [String]) -> Reels {
        return Reels(frame: frame, videoNames: videos)
    }
}
