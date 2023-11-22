//
//  FadeInCollectionView.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 15.11.2023.
//

import Foundation
import SwiftUI

/// A SwiftUI view representing a collection with a fade-in effect of scrolling.
///
/// This view utilizes a `CollectionView` to display a collection of items with a customizable fade-in effect.
///
/// - Parameters:
///   - items: A binding to an array of identifiable items.
///   - itemHeight: The height of each item.
///   - itemWidth: The width of each item.
///   - scrollDirection: The scroll direction of the collection view.
///   - sideItemScale: The scale factor applied to side items.
///   - sideItemAlpha: The alpha value applied to side items for the fade-in effect.
///   - contentForData: A closure providing the content view for each item in the collection.
///
/// The `FadeInCollectionView` allows users to create a collection view with a fade-in effect during scrolling,
/// providing a visually appealing transition between items.
/// - Author: Andrii Sulimenko
public struct FadeInCollectionView<Item: Identifiable, Content: View>: View where Item.ID: StringProtocol {
    /// A binding to an array of identifiable items.
    @Binding var items: [Item]
    
    /// The height of each card item.
    public let itemHeight: Int
    /// The width of each card item.
    public let itemWidth: Int
    /// The scroll direction of the collection view.
    public let scrollDirection: UICollectionView.ScrollDirection
    /// The scale factor applied to side items.
    public let sideItemScale: Double
    /// The alpha value applied to side items for the fade-in effect.
    public let sideItemAlpha: Double
    /// A closure providing the content view for each item in the collection.
    public let contentForData: (Item) -> Content
    
    public init(items: Binding<[Item]>, itemHeight: Int, itemWidth: Int, scrollDirection: UICollectionView.ScrollDirection, sideItemScale: Double, sideItemAlpha: Double ,contentForData: @escaping (Item) -> Content) {
        self._items = items
        self.itemHeight = itemHeight
        self.itemWidth = itemWidth
        self.scrollDirection = scrollDirection
        self.sideItemScale = sideItemScale
        self.sideItemAlpha = sideItemAlpha
        self.contentForData = contentForData
    }
    
    /// The body of the view, representing the content and layout of the collection with a fade-in effect.
    public var body: some View {
        CollectionView(
            collection: self.items,
            scrollDirection: self.scrollDirection,
            sideItemScale: self.sideItemScale,
            sideItemAlpha: self.sideItemAlpha,
            sideItemShift: 1.5,
            spacingMode: .overlap(visibleOffset: 0.0),
            contentSize: .fixed(CGSize(width: self.itemWidth, height: self.itemHeight)),
            itemSpacing: CollectionView.ItemSpacing(mainAxisSpacing: 0, crossAxisSpacing: 0),
            contentForData: { data in
                self.contentForData(data)
            }
        )
    }
}

