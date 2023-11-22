//
//  HostingController.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 01.11.2023.
//

import Foundation
import UIKit
import SwiftUI

// MARK: Hosting Controller
extension CollectionView {
    /// Class for defining hosted cell for  `UICollectionView`.
    ///
    /// A UICollectionViewCell that hosts a SwiftUI view using UIHostingController.
    ///
    /// - Note: This class inherits from `UICollectionViewCell`.
    /// - Author: Andrii Sulimenko
    final class HostedCollectionViewCell: UICollectionViewCell {
        /// The UIHostingController used to host the SwiftUI content.
        var viewController: UIHostingController<CellContent>?
        
        /// Provides the content to be displayed in the cell.
        /// - Parameter content: The SwiftUI view content to be displayed.
        func provide(_ content: CellContent) {
            if let viewController = self.viewController {
                viewController.rootView = content
            } else {
                let hostingController = UIHostingController(rootView: content)
                hostingController.view.backgroundColor = nil
                self.viewController = hostingController
            }
        }
        
        /// Attaches the cell to a parent view controller.
        /// - Parameter parentController: The parent UIViewController to which the cell will be attached.
        func attach(to parentController: UIViewController) {
            if let hostedController = self.viewController, let hostedView = hostedController.view {
                let contentView = self.contentView
                
                parentController.addChild(hostedController)
                
                hostedView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(hostedView)
                hostedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
                hostedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
                hostedView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
                hostedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
                
                hostedController.didMove(toParent: parentController)
            }
        }
        
        /// Detaches the cell from its parent view controller.
        func detach() {
            if let hostedController = self.viewController {
                guard hostedController.parent != nil, let hostedView = hostedController.view else { return }
                hostedController.willMove(toParent: nil)
                hostedView.removeFromSuperview()
                hostedController.removeFromParent()
            }
        }
    }
}

