//
//  CollectionViewCoordinator.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 01.11.2023.
//

import Foundation
import UIKit

extension CollectionView {
    /// The coordinator class responsible for managing the collection view data source and delegate.
    ///
    /// `Coordinator` class  conforms to `UICollectionViewDataSource`, `UICollectionViewDelegate`, and `UICollectionViewDelegateFlowLayout` protocols.
    public final class Coordinator : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        /// The associated `CollectionView` instance.
        var view: CollectionView
        /// The optional `ViewController` associated with the CollectionView.
        var viewController: ViewController?
        
        /// Initializes a new coordinator with the given `CollectionView`.
        ///
        /// - Parameter view: The associated `CollectionView` instance.
        init(view: CollectionView) {
            self.view = view
        }
        
        /// Returns the number of sections in the collection view.
        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return self.view.collections.count
        }
        
        /// Returns the number of items in the specified section.
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.view.collections[section].count
        }
        
        /// Calls the coordinator for a cell to insert in a particular location of the collection view.
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! HostedCollectionViewCell
            let data = self.view.collections[indexPath.section][indexPath.item]
            let content = self.view.contentForData(data)
            cell.provide(content)
            return cell
        }
        
        /// Informs the coordinator that the specified cell is about to be displayed in the collection view.
        public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let cell = cell as! HostedCollectionViewCell
            cell.attach(to: self.viewController!)
        }
        
        /// Informsv the coordinator that the specified cell was removed from the collection view.
        public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let cell = cell as! HostedCollectionViewCell
            cell.detach()
        }
        
        /// Informs the coordinator of the size of the specified item’s cell.
        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            switch self.view.contentSize {
            case .fixed(let size):
                return size
            case .variable(let sizeForData):
                let data = self.view.collections[indexPath.section][indexPath.item]
                return sizeForData(data)
            case .crossAxisFilled(let mainAxisLength):
                switch self.view.scrollDirection {
                case .horizontal:
                    return CGSize(width: mainAxisLength, height: collectionView.bounds.height)
                case .vertical:
                    fallthrough
                @unknown default:
                    return CGSize(width: collectionView.bounds.width, height: mainAxisLength)
                }
            case .custom(let customSizeForData):
                let data = self.view.collections[indexPath.section][indexPath.item]
                return customSizeForData(collectionView, collectionViewLayout, data)
            }
        }
        
        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return self.view.itemSpacing.mainAxisSpacing
        }
        
        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return self.view.itemSpacing.crossAxisSpacing
        }
        
        /// Informs the coordinator that the item at the specified index path was selected.
        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.scrollToItem(at: indexPath, at: view.scrollDirection == .horizontal ? .centeredHorizontally : .centeredVertically, animated: true)
        }
    }
}
