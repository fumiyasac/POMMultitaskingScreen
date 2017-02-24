//
//  POMCollectionViewFlowLayout.swift
//  POMMultitaskingScreen
//
//  Created by Jeremiah Gage on 1/28/15.
//  Copyright (c) 2015 Jeremiah Gage. All rights reserved.
//

import UIKit

class POMCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        var offsetAdjustment = MAXFLOAT;
        let horizontalOffset = proposedContentOffset.x + (self.collectionView!.bounds.size.width - self.itemSize.width) / 2.0
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        
        let array = super.layoutAttributesForElements(in: targetRect)
        
        for layoutAttributes in array! {
            let itemOffset = layoutAttributes.frame.origin.x;
            if (fabsf(Float(itemOffset - horizontalOffset)) < fabsf(offsetAdjustment)) {
                offsetAdjustment = Float(itemOffset - horizontalOffset)
            }
        }
        
        let offsetX = Float(proposedContentOffset.x) + offsetAdjustment
        return CGPoint(x: CGFloat(offsetX), y: proposedContentOffset.y)
    }
}
