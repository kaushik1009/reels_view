//
//  File.swift
//  
//
//  Created by kaushik on 01/08/24.
//

import UIKit
import AVFoundation

public class Reels: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    private var videoNames: [String]
    private var collectionView: UICollectionView!
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?

    public init(frame: CGRect, videoNames: [String]) {
        self.videoNames = videoNames
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(ReelsVideoCell.self, forCellWithReuseIdentifier: "ReelsVideoCell")
        self.addSubview(collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoNames.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelsVideoCell", for: indexPath) as! ReelsVideoCell
        cell.configure(with: videoNames[indexPath.row])
        return cell
    }
}
