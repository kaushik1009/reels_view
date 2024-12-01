//
//  File.swift
//  
//
//  Created by kaushik on 01/08/24.
//

import UIKit
import AVFoundation

public protocol ReelIndex {
    func updateReelIndex(_ index: Int)
}

// This view is responsible for constructing the collection view and logic for rending the AVPlayer on each collection view cells
public class Reels: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Private properties which are used within this class
    private var collectionView: UICollectionView!
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var videoNames: [Any]
    public var delegate: ReelIndex?

    public init(frame: CGRect, videoNames: [Any]) {
        self.videoNames = videoNames
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup collection view behavior and register cells
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ReelsVideoCell.self, forCellWithReuseIdentifier: "ReelsVideoCell")
        self.addSubview(collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoNames.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelsVideoCell", for: indexPath) as! ReelsVideoCell
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ReelsVideoCell else { return }
        cell.configure(with: videoNames[indexPath.row])
        delegate?.updateReelIndex(indexPath.row)
        cell.play()
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ReelsVideoCell else { return }
        cell.pause()
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playVisibleCell()
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            playVisibleCell()
        }
    }

    // Logic of playing the videos only on the visible cells on the screen which resolves the issue of multiple videos playing simultaneously
    private func playVisibleCell() {
        let visibleCells = collectionView.visibleCells.compactMap { $0 as? ReelsVideoCell }
        for cell in visibleCells {
            cell.play()
        }
        let nonVisibleCells = collectionView.subviews.compactMap { $0 as? ReelsVideoCell }.filter { !visibleCells.contains($0) }
        for cell in nonVisibleCells {
            cell.pause()
        }
    }
}
