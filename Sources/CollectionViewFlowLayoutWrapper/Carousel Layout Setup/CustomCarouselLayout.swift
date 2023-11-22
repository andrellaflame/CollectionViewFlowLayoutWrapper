//
//  CustomCarouselLayout.swift
//  CustomCarouselView
//
//  Created by Andrii Sulimenko on 23.10.2023.
//

import Foundation
import UIKit

/// Custom flow layout for a carousel-style UICollectionView.
///
/// This layout provides customization options for scaling, alpha, and shifting of side items in a carousel.
/// It supports both horizontal and vertical scrolling directions.
///
/// - Note: This class inherits from `UICollectionViewFlowLayout`.
///
/// - Author: Andrii Sulimenko
final class CarouselFlowLayout: UICollectionViewFlowLayout {

    // MARK: @IBInspectable variables
    /// The scale factor applied to side items. Defaults to 0.6.
    @IBInspectable public var sideItemScaleFactor: CGFloat = 0.6
    /// The alpha value applied to side items. Defaults to 0.6.
    @IBInspectable public var sideItemAlphaValue: CGFloat = 0.6
    /// The shift value applied to side items. Defaults to 0.0.
    @IBInspectable public var sideItemShiftValue: CGFloat = 0.0
    /// The spacing mode used for layout. Defaults to `.fixed(spacing: 40)`.
    public var spacingMode = CarouselFlowLayoutSpacingMode.fixed(spacing: 40)
    private var state = LayoutState(size: CGSize.zero, direction: .horizontal)

    /// Used for preparing layout for the controller. Additionally updating initial state of the layout
    override public func prepare() {
        super.prepare()
        let currentState = LayoutState(size: self.collectionView!.bounds.size, direction: self.scrollDirection)

        if !self.state.isEqual(currentState) {
            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
        }
    }

    /// Sets up the collection view with specific configurations.
    private func setupCollectionView() {
        guard let collectionView = self.collectionView else { return }
        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }

    /// Updates the layout based on the current configuration.
    private func updateLayout() {
        guard let collectionView = self.collectionView else { return }

        let collectionSize = collectionView.bounds.size
        let isHorizontal = (self.scrollDirection == .horizontal)

        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)

        let side = isHorizontal ? self.itemSize.width : self.itemSize.height
        
        let scaledItemOffset =  (side - side * self.sideItemScaleFactor) / 2
        
        switch self.spacingMode {
        
        case .fixed(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            let inset = isHorizontal ? xInset : yInset
            self.minimumLineSpacing = inset - fullSizeSideItemOverlap
        }
    }

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }

    private func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        let isHorizontal = (self.scrollDirection == .horizontal)

        let collectionCenter = isHorizontal ? collectionView.frame.size.width / 2 : collectionView.frame.size.height / 2
        let offset = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let normalizedCenter = (isHorizontal ? attributes.center.x : attributes.center.y) - offset

        let maxDistance = (isHorizontal ? self.itemSize.width : self.itemSize.height) + self.minimumLineSpacing
        
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        
        let ratio = (maxDistance - distance)/maxDistance

        let alpha = ratio * (1 - self.sideItemAlphaValue) + self.sideItemAlphaValue
        let scale = ratio * (1 - self.sideItemScaleFactor) + self.sideItemScaleFactor
        let shift = (1 - ratio) * self.sideItemShiftValue
        
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)

        if isHorizontal {
            attributes.center.y = attributes.center.y + shift
        } else {
            attributes.center.x = attributes.center.x + shift
        }

        return attributes
    }
    
    /// Determines the target content offset for a given proposed content offset and scrolling velocity.
    ///
    /// - Parameters:
    ///   - proposedContentOffset: The proposed content offset.
    ///   - velocity: The scrolling velocity.
    /// - Returns: The target content offset.
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView, !collectionView.isPagingEnabled, let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds) else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }

        let isHorizontal = self.scrollDirection == .horizontal

        let midSide = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
        
        let proposedContentOffsetCenterOrigin = (isHorizontal ? proposedContentOffset.x + (proposedContentOffset.x * velocity.x) : proposedContentOffset.y + (proposedContentOffset.y * velocity.y)) + midSide

        var targetContentOffset: CGPoint
        
        if isHorizontal {
            let closest = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        } else {
            let closest = layoutAttributes.sorted { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
        }

        return targetContentOffset
    }

    /// Indicates whether the layout flips horizontally in the opposite layout direction.
    override public var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
