//
//  CollectionView.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 01.11.2023.
//

import Foundation
import SwiftUI
import UIKit

/// A SwiftUI `UIViewControllerRepresentable` that wraps a UIKit `UICollectionView` with a custom layout.
///
/// This `CollectionView` is designed to work with SwiftUI and UIKit to create a collection view with a custom layout.
/// It supports various customization options for scroll direction, item scaling, alpha fading, spacing, and content size.
/// The collection view is populated with data from the provided collections using the specified contentForData closure.
///
/// - Parameters:
///   - collections: The main collections containing the items to be displayed in the collection view.
///   - scrollDirection: The scroll direction of the collection view. Defaults to `.vertical`.
///   - sideItemScale: The scale factor applied to side items in the custom layout.
///   - sideItemAlpha: The alpha value applied to side items in the custom layout for a fade-in effect.
///   - sideItemShift: The shift value applied to side items in the custom layout.
///   - spacingMode: The spacing mode used in the custom layout.
///   - contentSize: The content size of each item in the collection view.
///   - itemSpacing: The spacing between items in the collection view.
///   - rawCustomize: A closure providing additional customization for the collection view. Defaults to `nil`.
///   - contentForData: A closure providing the content view for each item in the collection.
/// - Author: Andrii Sulimenko
public struct CollectionView<Collections, CellContent>: UIViewControllerRepresentable
    where  Collections : RandomAccessCollection,
           Collections.Index == Int,
           Collections.Element : RandomAccessCollection,
           Collections.Element.Index == Int,
           Collections.Element.Element : Identifiable,
           CellContent : View {
    
    // MARK: CollectionView typealiases
    public typealias Row = Collections.Element
    public typealias Data = Row.Element
    public typealias ContentForData = (Data) -> CellContent
    public typealias ScrollDirection = UICollectionView.ScrollDirection
    public typealias SizeForData = (Data) -> CGSize
    public typealias CustomSizeForData = (UICollectionView, UICollectionViewLayout, Data) -> CGSize
    public typealias RawCustomize = (UICollectionView) -> Void
    
    // MARK: CollectionView Content Size
    /// Defines the content size types available for a `ContentView`.
    public enum ContentSize {
        case fixed(CGSize)
        case variable(SizeForData)
        case crossAxisFilled(mainAxisLength: CGFloat)
        case custom(CustomSizeForData)
    }
    
    // MARK: CollectionView Item Spacing
    /// Represents the spacing in between items of `CollectionView`.
    ///
    /// The `LayoutState` struct includes information about the size of the layout and the scroll direction.
    public struct ItemSpacing : Hashable {
        var mainAxisSpacing: CGFloat
        var crossAxisSpacing: CGFloat
        
        public init(mainAxisSpacing: CGFloat, crossAxisSpacing: CGFloat) {
            self.mainAxisSpacing = mainAxisSpacing
            self.crossAxisSpacing = crossAxisSpacing
        }
    }
    
    // MARK: Delegate & Data Source data
    public let collections: Collections
    public let contentForData: ContentForData
    
    public let scrollDirection: ScrollDirection
    public let sideItemScale, sideItemAlpha, sideItemShift: CGFloat
    public let spacingMode: CarouselFlowLayoutSpacingMode
    
    public let contentSize: ContentSize
    public let itemSpacing: ItemSpacing
    
    public let rawCustomize: RawCustomize?
    
    // MARK: Default init
    /// Creates a new `CollectionView` with the specified parameters.
    ///
    /// - Parameters:
    ///   - collections: The main collections containing the items to be displayed in the collection view.
    ///   - scrollDirection: The scroll direction of the collection view. Defaults to `.vertical`.
    ///   - sideItemScale: The scale factor applied to side items in the custom layout.
    ///   - sideItemAlpha: The alpha value applied to side items in the custom layout for a fade-in effect.
    ///   - sideItemShift: The shift value applied to side items in the custom layout.
    ///   - spacingMode: The spacing mode used in the custom layout.
    ///   - contentSize: The content size of each item in the collection view.
    ///   - itemSpacing: The spacing between items in the collection view.
    ///   - rawCustomize: A closure providing additional customization for the collection view. Defaults to `nil`.
    ///   - contentForData: A closure providing the content view for each item in the collection.
    public init(
        collections: Collections,
        scrollDirection: ScrollDirection = .vertical,
        sideItemScale: CGFloat,
        sideItemAlpha: CGFloat,
        sideItemShift: CGFloat,
        spacingMode: CarouselFlowLayoutSpacingMode,
        contentSize: ContentSize,
        itemSpacing: ItemSpacing = ItemSpacing(mainAxisSpacing: 0, crossAxisSpacing: 0),
        rawCustomize: RawCustomize? = nil,
        contentForData: @escaping ContentForData
    ) {
        self.collections = collections
        
        self.scrollDirection = scrollDirection
        self.sideItemScale = sideItemScale
        self.sideItemAlpha = sideItemAlpha
        self.sideItemShift = sideItemShift
        self.spacingMode = spacingMode
        
        self.contentSize = contentSize
        self.itemSpacing = itemSpacing
        self.rawCustomize = rawCustomize
        self.contentForData = contentForData
    }
    
    /// Creates a new `Coordinator` for `CollectionView` to represent Data Source & Delegate.
    public func makeCoordinator() -> Coordinator {
        return Coordinator(view: self)
    }
    
    /// Creates a new `ViewController` for `CollectionView` to host created `View`.
    public func makeUIViewController(context: Context) -> ViewController {
        let coordinator = context.coordinator
        let viewController = ViewController(
            coordinator: coordinator, 
            scrollDirection: self.scrollDirection,
            sideItemScale: self.sideItemScale,
            sideItemAlpha: self.sideItemAlpha,
            sideItemShift: self.sideItemShift,
            spacingMode: self.spacingMode
        )
        coordinator.viewController = viewController
        self.rawCustomize?(viewController.collectionView)
        return viewController
    }
    
    /// Updates created `ViewController` for hosting `CollectionView`.
    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        context.coordinator.view = self
        uiViewController.layout.scrollDirection = self.scrollDirection
        
        self.rawCustomize?(uiViewController.collectionView)
        
        uiViewController.collectionView.reloadData()
    }
}
