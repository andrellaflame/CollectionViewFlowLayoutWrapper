//
//  CollectionViewConvenianceInit.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 08.11.2023.
//

import Foundation
import UIKit

extension CollectionView {
    // MARK: Conveniance init
    /// Creates a new collection view with a single collection using default parameters.
    ///
    /// This convenience initializer is designed to simplify the creation of a `CollectionView` with a single collection.
    ///
    /// - Parameters:
    ///   - collection: The collection of items to be displayed in the collection view.
    ///   - scrollDirection: The scroll direction of the collection view. Defaults to `.vertical`.
    ///   - sideItemScale: The scale factor applied to side items in the custom layout. Defaults to `0.6`.
    ///   - sideItemAlpha: The alpha value applied to side items in the custom layout for a fade-in effect. Defaults to `0.6`.
    ///   - sideItemShift: The shift value applied to side items in the custom layout. Defaults to `0.0`.
    ///   - spacingMode: The spacing mode used in the custom layout. Defaults to `.fixed(spacing: 10)`.
    ///   - contentSize: The content size of each item in the collection view.
    ///   - itemSpacing: The spacing between items in the collection view. Defaults to no spacing.
    ///   - rawCustomize: A closure providing additional customization for the collection view. Defaults to `nil`.
    ///   - contentForData: A closure providing the content view for each item in the collection. Must be specified.
    public init<Collection>(
        collection: Collection,
        scrollDirection: ScrollDirection = .vertical,
        sideItemScale: CGFloat = 0.6,
        sideItemAlpha: CGFloat = 0.6,
        sideItemShift: CGFloat = 0.0,
        spacingMode: CarouselFlowLayoutSpacingMode = .fixed(spacing: 10),
        contentSize: ContentSize,
        itemSpacing: ItemSpacing = ItemSpacing(mainAxisSpacing: 0, crossAxisSpacing: 0),
        rawCustomize: RawCustomize? = nil,
        contentForData: @escaping ContentForData
    ) where Collections == [Collection] {
        self.init(
            collections: [collection],
            scrollDirection: scrollDirection,
            sideItemScale: sideItemScale,
            sideItemAlpha: sideItemAlpha,
            sideItemShift: sideItemShift,
            spacingMode: spacingMode,
            contentSize: contentSize,
            itemSpacing: itemSpacing,
            rawCustomize: rawCustomize,
            contentForData: contentForData)
    }
}
