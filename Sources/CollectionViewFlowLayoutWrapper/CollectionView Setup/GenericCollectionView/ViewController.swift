//
//  ViewController.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 01.11.2023.
//

import Foundation
import UIKit

extension CollectionView {
    /// A view controller for managing a collection view with a custom layout.
    ///
    /// This `ViewController` is designed to work with a `CollectionView` and a custom `CarouselFlowLayout`.
    ///
    /// - Parameters:
    ///   - coordinator: The coordinator responsible for managing data and interactions within the collection view.
    ///   - scrollDirection: The scroll direction of the collection view.
    ///   - sideItemScale: The scale factor applied to side items in the custom layout.
    ///   - sideItemAlpha: The alpha value applied to side items in the custom layout for a fade-in effect.
    ///   - sideItemShift: The shift value applied to side items in the custom layout.
    ///   - spacingMode: The spacing mode used in the custom layout.
    ///
    /// The `ViewController` initializes a collection view with a custom layout and provides a way to manage its appearance and behavior.
    ///  - Author: Andrii Sulimenko
    public final class ViewController : UIViewController {
        /// The custom `UICollectionViewFlowLayout` layout for the collection view.
        public let layout: UICollectionViewFlowLayout
        /// The collection view managed by this view controller.
        public let collectionView: UICollectionView
        
        /// Initializes a new view controller with the specified parameters.
        ///
        /// - Parameters:
        ///   - coordinator: The coordinator responsible for managing data and interactions within the collection view.
        ///   - scrollDirection: The scroll direction of the collection view.
        ///   - sideItemScale: The scale factor applied to side items in the custom layout.
        ///   - sideItemAlpha: The alpha value applied to side items in the custom layout for a fade-in effect.
        ///   - sideItemShift: The shift value applied to side items in the custom layout.
        ///   - spacingMode: The spacing mode used in the custom layout.
        public init(
            coordinator: Coordinator,
            scrollDirection: ScrollDirection,
            sideItemScale: CGFloat,
            sideItemAlpha: CGFloat,
            sideItemShift: CGFloat,
            spacingMode: CarouselFlowLayoutSpacingMode
        ) {
            let layout = CarouselFlowLayout()
            
            layout.scrollDirection = scrollDirection
            layout.sideItemScaleFactor = sideItemScale
            layout.sideItemAlphaValue = sideItemAlpha
            layout.sideItemShiftValue = sideItemShift
            layout.spacingMode = spacingMode
            
            self.layout = layout
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = nil
            collectionView.register(HostedCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
            collectionView.dataSource = coordinator
            collectionView.delegate = coordinator
            self.collectionView = collectionView
            super.init(nibName: nil, bundle: nil)
        }
                
        required init?(coder: NSCoder) {
            fatalError("ViewController is not connected to interface builder")
        }
        
        public override func loadView() {
            self.view = self.collectionView
        }
    }
}


// MARK: Cell Reuse Identifier
extension CollectionView {
    /// A static property representing the cell reuse identifier for the collection view.
    static var cellReuseIdentifier: String {
        return "HostedCollectionViewCell"
    }
}
