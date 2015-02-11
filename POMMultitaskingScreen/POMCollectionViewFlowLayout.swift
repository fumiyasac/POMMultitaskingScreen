//
//  POMCollectionViewFlowLayout.swift
//  POMMultitaskingScreen
//
//  Created by Jeremiah Gage on 1/28/15.
//  Copyright (c) 2015 Jeremiah Gage. All rights reserved.
//

import UIKit

class POMCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        var offsetAdjustment = MAXFLOAT;
        var horizontalOffset = proposedContentOffset.x + (self.collectionView!.bounds.size.width - self.itemSize.width) / 2.0
        var targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView!.bounds.size.width, self.collectionView!.bounds.size.height)
        
        var array = super.layoutAttributesForElementsInRect(targetRect)
        
        for layoutAttributes in array! {
            var itemOffset = layoutAttributes.frame.origin.x;
            if (fabsf(Float(itemOffset - horizontalOffset)) < fabsf(offsetAdjustment)) {
                offsetAdjustment = Float(itemOffset - horizontalOffset)
            }
        }
        
        var offsetX = Float(proposedContentOffset.x) + offsetAdjustment
        return CGPointMake(CGFloat(offsetX), proposedContentOffset.y)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]?
    {
        let attributesArray = super.layoutAttributesForElementsInRect(rect)  as! [UICollectionViewLayoutAttributes]
        var visibleRect:CGRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
        for attributes in attributesArray {
            if attributes.representedElementCategory == UICollectionElementCategory.Cell {
                if CGRectIntersectsRect(attributes.frame, rect) {
                    self.setCellAttributes(attributes, visibleRect:visibleRect)
                }
            }
        }
        return attributesArray
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
    {
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        var visibleRect:CGRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
        self.setCellAttributes(attributes, visibleRect:visibleRect)
        return attributes
    }
    
    func setCellAttributes(attributes:UICollectionViewLayoutAttributes, visibleRect:CGRect)
    {
        let distance = CGRectGetMidX(visibleRect) - attributes.center.x
        let normalizedDistance = distance / visibleRect.size.width
        let invertedDistance = 1.0 - abs(normalizedDistance)

        attributes.zIndex = Int(visibleRect.size.width - abs(distance))
        
        var transform:CATransform3D = CATransform3DIdentity
        let scale = pow(abs(invertedDistance), 6.0)
        transform = CATransform3DIdentity
        
        transform = CATransform3DTranslate(transform, -4.0 * distance * scale, 0.0, 0.0)
        transform = CATransform3DScale(transform, scale, scale, 1.0)
        attributes.transform3D = transform
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
