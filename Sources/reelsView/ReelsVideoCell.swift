//
//  File.swift
//  
//
//  Created by kaushik on 01/08/24.
//

import Foundation
import UIKit
import AVKit

// UICollectionViewCell to configure AVPlayer within each cell which renders the video
open class ReelsVideoCell: UICollectionViewCell {
    
    // Private properties which are used within this class
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var playerLooper: AVPlayerLooper?
    private var playerQueue: AVQueuePlayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerLayer()
        setupActivityIndicator()
    }
    
    // PrepareForReuse is used to make the next cell to start fresh with the respective video item, so we make the playerQueue to pause and remove all items in the queue
    public override func prepareForReuse() {
        super.prepareForReuse()
        playerQueue?.pause()
        playerQueue?.removeAllItems()
        playerLayer?.player = nil
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Setup AVPlayer layer into collection view cell's content view
    private func setupPlayerLayer() {
        playerLayer = AVPlayerLayer()
        playerLayer?.frame = self.contentView.bounds
        playerLayer?.videoGravity = .resizeAspect
        self.contentView.layer.addSublayer(playerLayer!)
    }
    
    // Setup activity indicator which loads until each video gets rendered
    private func setupActivityIndicator() {
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // Configure method to add the videos into the playerQueue. It accepts both url and string from local path
    open func configure(with url: Any) {
        activityIndicator.startAnimating()
        playerQueue = AVQueuePlayer()
        if type(of: url) == type(of: "") {
            if let videoPath = Bundle.main.path(forResource: url as? String ?? "", ofType: "mp4") {
                let videoURL = URL(fileURLWithPath: videoPath)
                let playerItem = AVPlayerItem(url: videoURL)
                playerLooper = AVPlayerLooper(player: playerQueue!, templateItem: playerItem)
            }
        } else {
            let playerItem = AVPlayerItem(url: url as! URL)
            playerLooper = AVPlayerLooper(player: playerQueue!, templateItem: playerItem)
        }
        playerLayer?.player = playerQueue
    }

    // Video player plays
    open func play() {
        self.playerQueue?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    // Video player pauses
    open func pause() {
        playerQueue?.pause()
    }
}
