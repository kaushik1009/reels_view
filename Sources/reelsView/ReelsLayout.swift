//
//  File.swift
//  
//
//  Created by kaushik on 01/08/24.
//

import Foundation
import UIKit

public class ReelsLayout: UICollectionViewFlowLayout {
    
    public override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        itemSize = collectionView?.bounds.size ?? CGSize(width: 0, height: 0)
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
        
        guard let collectionView = collectionView else { return attributes }
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        
        for attribute in attributes! {
            if attribute.frame.intersects(visibleRect) {
                let distance = visibleRect.midY - attribute.center.y
                let normalizedDistance = distance / collectionView.bounds.height
                let zoom = 1 + 0.2 * (1 - abs(normalizedDistance))
                attribute.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
                attribute.alpha = zoom - 0.2
            }
        }
        
        return attributes
    }
}
