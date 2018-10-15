# MBSegmentControll

![](https://img.shields.io/badge/Swift-4.0-green.svg?style=flat)
[![Version](https://img.shields.io/cocoapods/v/MBSegmentControll.svg?style=flat)](https://cocoapods.org/pods/MBSegmentControll)
[![License](https://img.shields.io/cocoapods/l/MBSegmentControll.svg?style=flat)](https://cocoapods.org/pods/MBSegmentControll)
[![Platform](https://img.shields.io/cocoapods/p/MBSegmentControll.svg?style=flat)](https://cocoapods.org/pods/MBSegmentControll)

## About
A fully customizable SegmentControll with right to left support

## Features:
- Variable number of items 
- Animated transition
- supprts for right_to_left language
- Supporting image and tetx for items
- Designable into Interface Builder

![sample](https://i.imgur.com/Wkz9Ezm.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+

## Installation

- CocoaPods

MBSegmentControll is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MBSegmentControll'
```

Manually

Add the MBSegmentControll file to your project.



## Usage

- CocoaPods

In the controller You want to use 'import MBSegmentControll'

``` swift

import MBSegmentControll 
```

- Programatic:

``` swift
lazy var segmetControll: MBSegmentControll = {
    let segmetControll = MBSegmentControll()
    segmetControll.buttonTitles = ["First", "Second", "Third"]
    segmetControll.borderWidth = 1
    segmetControll.borderColor = .lightGray
    segmetControll.roundCorner = true
    segmetControll.isLine = false
    segmetControll.textColor = .cyan
    segmetControll.selectedTextColor = .white
    segmetControll.translatesAutoresizingMaskIntoConstraints = false
    segmetControll.addTarget(self, action: #selector(segmentTapped(_:)), for: .valueChanged)

    return segmetControll
}()
```

Inside `viewDidLoad` add segmetControll to be subview of controller view 

``` swift
override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(segmetControll)
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: [], metrics: nil, views: ["v1": segmetControll]))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[v1(50)]", options: [], metrics: nil, views: ["v1": segmetControll]))
    segmetControll.selecteSegment(at: 1)
}
```
Handling action for selection state

``` swift
@objc func segmentTapped(_ sender: MBSegmentControll) {
    // returns currently selected item index
    print(sender.selectedSegmentIndex)
}
```

- Interface Builder:

Add a UIView and set it's class to MBSegmentControll. You can customize the control directly from the interface builder.

This is fully Customizable over Interface Builder exept font and images that Interface Builder currently dose not support

![](https://i.imgur.com/8FYxhrc.png)

- Manually

Same as cocoapods exept there is no need to import MBSegmentControll 

## How to customize?
Check the Example project inside the pod 

For custom image or text outside of Interface builder there is properties for each one.

```swift
// use text as title
segmetControll.buttonTitles = ["First", "Second", "Third"]


// use Image as title placeholder
imageSegment.buttonImages = [
    #imageLiteral(resourceName: "home"), 
    #imageLiteral(resourceName: "edit"), 
    #imageLiteral(resourceName: "message")
]
```

If you want thumbView to be line, default behavior is set to do that or

```swift
// by default is true
segmetControll.isLine = true

// for rectangle change it to false
segmetControll.isLine = false

// for oval shape on thumbView
segmetControll.roundCorner = true
segmetControll.isLine = false
```

In orther to change selected segment after Initialization there is build on method that can be used, ang it trigger the action method if you set one

```swift
segmetControll.selecteSegment(at: 0)
```

MBSegmentControll fully support right_to_left languages.


## License

MBSegmentControll is available under the MIT license. See the LICENSE file for more info.
