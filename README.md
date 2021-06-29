# Fampay assignment using SwiftUI

![](https://github.com/devwaseem/Fampay-assignment-iOS-SwiftUI/raw/main/github%20assets/app.gif)

## 📡  Frameworks used
### 🍎 Internal
 - SwiftUI - To build views
 - Combine - To bind data with views
 - Coredata - To store the ignore list for big display card
### 👽 3rd party
 - [KingFisher](https://github.com/onevcat/Kingfisher) - To load images asynchronously

## 🏛 Architecture
 - MVVM using Combine

## ⚠️ Note
### [`FormattedTextView`](https://github.com/devwaseem/Fampay-assignment-iOS-SwiftUI/blob/main/Fampay%20assignment/Views/ContextualCards/BigDisplayContextualCard/FormattedTextView.swift)
SwiftUI doesn't support **Attributed strings** (iOS 14 and below), Also the **NSAttributedString + UITextView** doesn't support different color for links.
To acheive the required result, the Formatted title and Formatted Desription views uses **[`FlexibleHGrid`](https://github.com/devwaseem/Fampay-assignment-iOS-SwiftUI/blob/main/Fampay%20assignment/Views/FlexibleHGrid.swift)** to layout different Views stacked together horizonatally. This prones to error because of variable length of text. The workarounds have been built to solve some inconsistencies.

### [`RefreshableScrollView`](https://github.com/devwaseem/Fampay-assignment-iOS-SwiftUI/blob/main/Fampay%20assignment/Views/RefreshableScrollView.swift)
Since there is no support for refreshing in SwiftUI (iOS 14 and below), Custom [`RefreshableScrollView`](https://github.com/devwaseem/Fampay-assignment-iOS-SwiftUI/blob/main/Fampay%20assignment/Views/RefreshableScrollView.swift) is implemented.

 
 
