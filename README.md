# CollectionViewFlowLayoutWrapper

![Swift Version](https://img.shields.io/badge/Swift-4.2-orange.svg)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A convenient and customizable wrapper for using `UICollectionView` with `SwiftUI` through a generic interface. This project simplifies the integration of a `UICollectionView` with different flow layouts by leveraging the power of `UICollectionViewFlowLayout` in SwiftUI.

## Features

- ✨ Seamless integration of `UICollectionView` with SwiftUI.
- 🎨 Easily customize the appearance and behavior of the collection view.
- 🔄 Supports dynamic data binding for efficient updates.
- 🚀 High-performance scrolling with `UICollectionViewFlowLayout`.
- 📱 Compatible with all iOS devices running iOS 13.0 and above.
- 📦 Includes some pre-defined CollectionViews for defined flow layout.

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift` file:

```
swift
dependencies: [
    .package(url: "https://github.com/andrellaflame/CollectionViewFlowLayoutWrapper.git", from: "1.0.0")
]
```

### CocoaPods

Install pod for `CollectionViewFlowLayoutWrapper`
```
pod install 'CollectionViewFlowLayoutWrapper'
```

## Usage

#### Step 1: Framework installation

Install the framework. 

For detailed instructions, refer to the [Installation](#installation) section.

#### Step 2: Import the Module

Add the following import to any Swift file where you want to use the collection view: 

```
import CollectionViewFlowLayoutWrapper
```

#### Step 3: Prepare Your Data and Cell View

Define your data model and the corresponding SwiftUI view (cell):

> ``NOTE:`` Your data type must conform to the `Identifiable` protocol, while your cell must be a SwiftUI View.

#### Step 4: Initialize a CollectionView

You can use the built-in `CollectionView` or choose from several pre-configured layouts.

##### Example 1: CardsCollectionView

> 📝 A horizontally scrollable card-style layout. 
> This `CollectionView` defines SwiftUI view representing a `CollectionView` with `CardsLayout` customizable and content.

```
CardsCollectionView(
    items: $items,
    itemHeight: 500,
    itemWidth: 260,
    scrollDirection: .horizontal,
    contentForData: { data in
    CollectionViewCustomCell(data: data)
    }
)
```

##### Example 2: FadeInCollectionView

> 📝 A vertical layout with a fade-in effect for side items.
> This `CollectionView` defines SwiftUI view representing a collection with a fade-in effect of scrolling.

```
FadeInCollectionView(
    items: $items,
    itemHeight: 100,
    itemWidth: 100,
    scrollDirection: .vertical,
    sideItemScale: 0.6,
    sideItemAlpha: -1.5,
    contentForData: { data in
    CollectionViewCustomCell(data: data)
    }
)
```

##### Example 3: Generic CollectionView

> 📝 A default layout using a fixed item size and a custom cell.
> This `CollectionView` uses convenience init.

```
CollectionView(
    collection: self.items,
    contentSize: .fixed(CGSize(width: 100, height: 100)),
    contentForData: { data in
    CollectionViewCustomCell(data: data)
    }
)
```
