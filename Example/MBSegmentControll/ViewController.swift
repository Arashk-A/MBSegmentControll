//
//  ViewController.swift
//  MBSegmentControll
//
//  Created by Arashk-A on 10/13/2018.
//  Copyright (c) 2018 Arashk-A. All rights reserved.
//

import UIKit
import MBSegmentControll

class ViewController: UIViewController {

    @IBOutlet weak var imageSegment: MBSegmentControll!
    @IBOutlet weak var rightToLeftsegment: MBSegmentControll!
    
    // create prigramicly
    lazy var segmetControll: MBSegmentControll = {
        let segmetControll = MBSegmentControll()
        segmetControll.buttonTitles = ["First", "Second", "Third"]
        segmetControll.borderWidth = 1
        segmetControll.borderColor = .lightGray
        segmetControll.roundCorner = true
        segmetControll.isLine = false
        segmetControll.textColor = .cyan
        segmetControll.selectedTextColor = .white
        segmetControll.selectedColor = .black
        segmetControll.translatesAutoresizingMaskIntoConstraints = false
        segmetControll.addTarget(self, action: #selector(segmentTapped(_:)), for: .valueChanged)
        
        return segmetControll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentControll()
        
        // set image to segments
        imageSegment.buttonImages = [#imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "edit"), #imageLiteral(resourceName: "message")]
    }
    
    func setupSegmentControll() {
        view.addSubview(segmetControll)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: [], metrics: nil, views: ["v1": segmetControll]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[v1(50)]", options: [], metrics: nil, views: ["v1": segmetControll]))
    }

    @IBAction func segmentTapped(_ sender: MBSegmentControll) {
        
        print(sender.selectedSegmentIndex)
        print(sender.titles)
    }
    
    @IBAction func imageSegmentTaped(_ sender: MBSegmentControll) {
        rightToLeftsegment.selecteSegment(at: sender.selectedSegmentIndex)
    }
}

