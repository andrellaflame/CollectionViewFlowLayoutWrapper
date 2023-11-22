//
//  LayoutState.swift
//  CustomCarouselView
//
//  Created by Andrii Sulimenko on 23.10.2023.
//

import Foundation
import UIKit

/// Represents the state of a layout in a UICollectionView.
///
/// The `LayoutState` struct includes information about the size of the layout and the scroll direction.
/// - Author: Andrii Sulimenko
struct LayoutState {
    var size: CGSize
    var direction: UICollectionView.ScrollDirection
    
    /// Compares the current layout state with another layout state.
    ///
    /// - Parameter otherState: The layout state to compare with.
    /// - Returns: `true` if the two layout states are equal, otherwise `false`.
    func isEqual(_ otherState: LayoutState) -> Bool {
        return self.size.equalTo(otherState.size) && self.direction == otherState.direction
    }
}
