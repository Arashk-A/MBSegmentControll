//
//  MBSegmentControll.swift
//  MBSegmentControll
//
//  Created by Birang on 10/13/18.
//  Copyright © 2018 Birang. All rights reserved.
//

import Foundation
import UIKit

public enum SelectorType: Int {
    case line
    case oval
}

@IBDesignable
open class MBSegmentControll: UIControl {
    private var buttons: [UIButton] = []
    private var thumbViewLeadingConstraints: NSLayoutConstraint!
    private var thumbViewHeightConstraints: NSLayoutConstraint!
    private var thumbViewWidthConstraints: NSLayoutConstraint!
    private var isText = true
    private var thumbView: UIView!
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()

        updateThumbView()
    
    }

    private(set) public var selectedSegmentIndex: Int = 0
    
    var selectionType: SelectorType = .line {
        didSet {
            configThumbViewHeight()
        }
    }
    
    @IBInspectable public var isLine: Bool = true {
        didSet {
            selectionType = isLine ? .line : .oval
        }
    }
    
    @IBInspectable public var selectItemAtIndex: Int = 0 {
        didSet {
            selecteSegment(at: selectItemAtIndex)
        }
    }
    
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var numberOfItems: Int = 2 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var roundCorner: Bool = false {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var selectedColor: UIColor = .lightGray {
        didSet {
            thumbView.backgroundColor = selectedColor
        }
    }
    
    @IBInspectable public var thumbViewHeight: CGFloat = 5 {
        didSet {
            configThumbViewHeight()
        }
    }
    
    @IBInspectable public var titles: String = "" {
        didSet {
            buttonTitles = titles.components(separatedBy: ",")
        }
    }
    
    @IBInspectable public var textColor: UIColor = .lightGray
    @IBInspectable public var selectedTextColor: UIColor = .white
    
    public var buttonTitles: [String] = []  {
        didSet {
            numberOfItems = buttonTitles.count
            isText = true
        }
    }
    
    public var buttonImages: [UIImage] = [] {
        didSet {
            numberOfItems = (buttonImages.count > 0) ? buttonImages.count : numberOfItems
            isText = false
        }
    }
    
    public var font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    public func selecteSegment(at index: Int) {
        if (0..<numberOfItems).contains(index) {
            buttonTaped(buttons[index])
        }
    }
    
    private func resetView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func updateView() {
        roundCorner ? addRoundCorner(to: self) : addCornerRadius(to: self)
        resetView()
        
        setupThumbView()
        
        setupButtons()
        
        setupStackView()
        
        update(selected: buttons[selectedSegmentIndex], at: selectedSegmentIndex)
        updateThumbView()
        
    }
    
    private func setupThumbView() {
        thumbView = UIView()
        thumbView.translatesAutoresizingMaskIntoConstraints = false
        thumbView.backgroundColor = selectedColor
        addSubview(thumbView)
        
        if (roundCorner == true && selectionType == .oval) {
            addRoundCorner(to: thumbView)
        }
        
        thumbViewLeadingConstraints = NSLayoutConstraint(item: thumbView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        addConstraint(thumbViewLeadingConstraints)
        
        addConstraint(NSLayoutConstraint(item: thumbView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        thumbViewWidthConstraints = NSLayoutConstraint(item: thumbView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (frame.width / CGFloat(numberOfItems)))
        addConstraint(thumbViewWidthConstraints)
        
        thumbViewHeightConstraints = NSLayoutConstraint(item: thumbView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        addConstraint(thumbViewHeightConstraints)

        configThumbViewHeight()
    }
    
    private func configThumbViewHeight() {
        guard thumbViewHeightConstraints != nil else { return }
        
        switch selectionType {
        case .line:
            let height = (thumbViewHeight > 0 && thumbViewHeight <= bounds.height) ? thumbViewHeight : 5
            thumbViewHeightConstraints.constant = height
        default:
            thumbViewHeightConstraints.constant = bounds.height
        }
    }
    
    private func setupButtons() {
        for index in 0..<numberOfItems {
            let button = UIButton(type: .system)
            button.tintColor = textColor
            
            isText ? setTitle(to: button, at: index) : setImage(to: button, at: index)
            
            button.addTarget(self, action: #selector(buttonTaped(_:)), for: .touchUpInside)
            buttons.append(button)
        }
    }
    
    private func setTitle(to button: UIButton, at index: Int) {
        if buttonTitles.count == numberOfItems {
            button.setTitle(buttonTitles[index], for: .normal)
        } else {
            button.setTitle("Item \(index+1)", for: .normal)
        }
        button.titleLabel?.font = font
    }
    
    private func setImage(to button: UIButton, at index: Int) {
        button.tintColor = textColor
        button.setImage(buttonImages[index], for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10
        )
    }
    
    @objc private func buttonTaped(_ sender: UIButton) {
        for (idx, button) in buttons.enumerated() {
            button.tintColor = textColor
            
            if button == sender {
                animateThumbView(to: button, at: idx)
            }
        }
        
        sendActions(for: .valueChanged)
    }
    
    private func animateThumbView(to button: UIButton, at index: Int) {
        update(selected: button, at: index)
        updateThumbView()
        
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
    }
    
    private func update(selected button: UIButton, at index: Int) {
        button.tintColor = selectedTextColor
        selectedSegmentIndex = index
    }
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.semanticContentAttribute = semanticContentAttribute
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: [], metrics: nil, views: ["v0": stackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: ["v0": stackView]))
    }
    
    private func updateThumbView() {
        guard thumbViewWidthConstraints != nil, thumbViewLeadingConstraints != nil else { return }
        thumbViewWidthConstraints.constant = bounds.width / CGFloat(numberOfItems)
        thumbViewLeadingConstraints.constant = CGFloat(selectedSegmentIndex) * (bounds.width / CGFloat(numberOfItems))
    }
    
    private func addRoundCorner(to view: UIView) {
        view.layer.cornerRadius = self.bounds.height / 2
        view.clipsToBounds = true
        view.layer.masksToBounds = true
    }
    
    private func addCornerRadius(to view: UIView) {
        view.layer.cornerRadius = 0
        view.layer.masksToBounds = true
    }
}
