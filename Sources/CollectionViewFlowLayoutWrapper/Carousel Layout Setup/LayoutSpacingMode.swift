//
//  LayoutSpacingMode.swift
//  CarouselLayout
//
//  Created by Andrii Sulimenko on 08.11.2023.
//

import Foundation

// MARK: Layout Spacing Mode
/// Defines the spacing modes available for a `CarouselFlowLayout`.
///
/// `CarouselFlowLayoutSpacingMode` is used for `CarouselFlowLayout` configuration.
/// - Author: Andrii Sulimenko
public enum CarouselFlowLayoutSpacingMode {
    /// Fixed spacing between items.
    ///
    /// - Parameter spacing: The fixed spacing value.
    case fixed(spacing: CGFloat)
    /// Overlapping spacing between items with a specified visible offset.
    ///
    /// - Parameter visibleOffset: The visible offset for overlapping.
    case overlap(visibleOffset: CGFloat)
}
