//
//  SyncCollectionView.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/9/23.
//

import UIKit

class SynchronizedScrollFlowLayout: UICollectionViewFlowLayout {
    weak var timelineCollectionView: UICollectionView?
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let timelineCollectionView = timelineCollectionView else {
            return proposedContentOffset
        }
        
        let xOffset = timelineCollectionView.contentOffset.x
        return CGPoint(x: xOffset, y: proposedContentOffset.y)
    }
}
