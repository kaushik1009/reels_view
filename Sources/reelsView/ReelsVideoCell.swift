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
    
    public var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlayerLayer()
    }
    
    private func setupPlayerLayer() {
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        if let playerLayer = playerLayer {
            layer.addSublayer(playerLayer)
        }
    }
    
    public func configure(with url: URL) {
        player = AVPlayer(url: url)
        playerLayer?.player = player
        player?.play()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        player = nil
        playerLayer?.player = nil
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
}
