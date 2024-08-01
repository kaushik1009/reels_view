//
//  File.swift
//  
//
//  Created by kaushik on 01/08/24.
//

import Foundation
import UIKit
import AVKit

public class ReelsVideoCell: UICollectionViewCell {
    private var playerLayer: AVPlayerLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPlayerLayer() {
        playerLayer = AVPlayerLayer()
        playerLayer?.frame = self.contentView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        self.contentView.layer.addSublayer(playerLayer!)
    }

    func configure(with videoName: String) {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("Video file \(videoName).mp4 not found in bundle")
            return
        }
        let player = AVPlayer(url: url)
        playerLayer?.player = player
        player.play()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.player = nil
    }
}
