//
//  CardsCollectionView.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 15.11.2023.
//

import Foundation
import SwiftUI

/// A SwiftUI view representing a `CollectionView` with `CardsLayout` customizable and content.
///
/// This view utilizes a `CollectionView` to display a carousel-style collection of cards.
///
/// - Parameters:
///   - items: A binding to an array of identifiable items.
///   - itemHeight: The height of each card item.
///   - itemWidth: The width of each card item.
///   - scrollDirection: The scroll direction of the collection view.
///   - contentForData: A closure that provides the content view for each item in the collection.
///
/// The `CardsCollectionView` allows users to pass their own custom cell content for the collection view,
/// providing flexibility in defining the appearance and behavior of the cards.
/// - Author: Andrii Sulimenko
public struct CardsCollectionView<Item: Identifiable, Content: View>: View where Item.ID: StringProtocol {
    /// A binding to an array of identifiable items.
    @Binding var items: [Item]
    
    /// The height of each card item.
    public let itemHeight: Int
    /// The width of each card item.
    public let itemWidth: Int
    /// The scroll direction of the collection view.
    public let scrollDirection: UICollectionView.ScrollDirection
    /// A closure providing the content view for each item in the collection.
    public let contentForData: (Item) -> Content
    
    public init(items: Binding<[Item]>, itemHeight: Int, itemWidth: Int, scrollDirection: UICollectionView.ScrollDirection, contentForData: @escaping (Item) -> Content) {
        self._items = items
        self.itemHeight = itemHeight
        self.itemWidth = itemWidth
        self.scrollDirection = scrollDirection
        self.contentForData = contentForData
    }
    
    /// The body of the view, representing the content and layout of the card collection.
    public var body: some View {
        CollectionView(
            collection: self.items,
            scrollDirection: self.scrollDirection,
            sideItemScale: 0.8,
            sideItemAlpha: 0.5,
            sideItemShift: 0.5,
            spacingMode: .overlap(visibleOffset: 0.8),
            contentSize: .fixed(CGSize(width: self.itemWidth, height: self.itemHeight)),
            itemSpacing: CollectionView.ItemSpacing(mainAxisSpacing: 0, crossAxisSpacing: 0),
            contentForData: { data in
                self.contentForData(data)
            }
        )
    }
}
