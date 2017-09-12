//
//  ViewController.swift
//  Dynamics
//
//  Created by WJ on 15/11/19.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

struct kInitial{
    static let point1 = CGPoint(x: 50, y: 100)
    static let point2 = CGPoint(x: 200, y: 100)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var box1: UIView!
    
    @IBOutlet weak var box2: UIView!
    
    var dynamicAnimator:UIDynamicAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        reset()
    }

    @IBAction func reset() {
        dynamicAnimator.removeAllBehaviors()
        box1.center = kInitial.point1
        box1.transform = CGAffineTransform.identity
        box2.center = kInitial.point2
        box2.transform = CGAffineTransform.identity
    }

    @IBAction func snap() {
        let point = randomPoint()
        let snap = UISnapBehavior(item: box1, snapTo: point)
        snap.damping = 0.25
        addTemporaryBehavior(snap)
    }

    @IBAction func attach() {
        let attach1 = UIAttachmentBehavior(item: box1, offsetFromCenter: UIOffsetMake(25, 25), attachedToAnchor: box1.center)
        dynamicAnimator.addBehavior(attach1)
        
        let attach2 = UIAttachmentBehavior(item: box1, attachedTo: box2)
        dynamicAnimator.addBehavior(attach2)
        
        let push = UIPushBehavior(items: [box1], mode: .instantaneous)
        push.pushDirection = CGVector(dx: 0, dy: 2)
        dynamicAnimator.addBehavior(push)
    }

    @IBAction func push() {
        let push = UIPushBehavior(items: [box1], mode: .instantaneous)
        push.pushDirection = CGVector(dx: 1, dy: 1)
        dynamicAnimator.addBehavior(push)
    }
    
    @IBAction func gravity() {
        let gravity = UIGravityBehavior(items: [box1,box2])
        gravity.action = { print(self.box1.center)}
        dynamicAnimator.addBehavior(gravity)
    }
    
    @IBAction func collision() {
        let collision = UICollisionBehavior(items: [box1,box2])
        dynamicAnimator.addBehavior(collision)
        
        let push = UIPushBehavior(items: [box1], mode: .instantaneous)
        push.pushDirection = CGVector(dx: 3, dy: 0)
        addTemporaryBehavior(push)
    }

    //MARK:- Uility
    func randomPoint()->CGPoint{
        let size = view.bounds.size
        let dx =  CGFloat(arc4random()%100)/100.0
        let dy =  CGFloat(arc4random()%100)/100.0
        return CGPoint(x: size.width * dx, y: size.height * dy)
    }
    
    func addTemporaryBehavior(_ behavior: UIDynamicBehavior){
        dynamicAnimator.addBehavior(behavior)
        dynamicAnimator.perform(#selector(UIDynamicAnimator.removeBehavior(_:)), with: behavior, afterDelay: 1)
    }
    
    
}

