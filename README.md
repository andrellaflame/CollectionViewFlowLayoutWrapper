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

#### Step 1

Framework installation. To view installation steps look into `Installation` part.

#### Step 2

Import `CollectionViewFlowLayoutWrapper` into your file.
```
import CollectionViewFlowLayoutWrapper
```

#### Step 3

Define data and cell to pass in your `UICollectionView`.

> ``NOTE:`` Data for cell must conform to `Identifieble` protocol. Cell can be any custom struct that is conformed to `View` protocol.

#### Step 4

Call `CollectionView` initializer with a set of properties using default or convenience init. 

##### Example 1

> 📝 Example of pre-defined `CollectionView` usage. This `CollectionView` defines SwiftUI view representing a `CollectionView` with `CardsLayout` customizable and content.

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

##### Example 2

> 📝 Example of pre-defined `CollectionView` usage. This `CollectionView` defines SwiftUI view representing a collection with a fade-in effect of scrolling.

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

##### Example 3

> 📝 Example of default `CollectionView` usage. This `CollectionView` uses convenience init.

```
CollectionView(
    collection: self.items,
    contentSize: .fixed(CGSize(width: 100, height: 100)),
    contentForData: { data in
    CollectionViewCustomCell(data: data)
    }
)
```
