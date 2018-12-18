//
//  ViewController.swift
//  实验10.1
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 2016110319. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var firstView: UIView!
    var secondView: UIView!
    var animator: UIDynamicAnimator!
    
    @IBOutlet weak var backView: UIView!
    //lazy var animator = UIDynamicAnimator(referenceView: self.backView)
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        animation()
        transition()
        animator = UIDynamicAnimator(referenceView: self.view)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        collision.translatesReferenceBoundsIntoBoundary = true
    }
    
    func animation() {
        let view = UIView(frame: CGRect(x: 300, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.blue
        self.view.addSubview(view)
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            view.frame = CGRect(x: 0, y: 20, width: 10, height: 10)
            view.backgroundColor = UIColor.yellow
            view.transform = view.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }
    
    func transition() {
        
        let btn = UIButton(frame: CGRect(x: 150, y: 300, width: 100, height: 44))
        btn.setTitle("切换视图", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(changeView), for: .touchUpInside)
        self.view.addSubview(btn)
        
        firstView = UIView(frame: CGRect(x: 300, y: 300, width: 100, height: 100))
        firstView.backgroundColor = UIColor.purple
        self.view.addSubview(firstView)
        
        secondView = UIView(frame: CGRect(x: 300, y: 300, width: 100, height: 100))
        secondView.backgroundColor = UIColor.black
        self.view.addSubview(secondView)
        
    }
    
    @objc func changeView() {
        UIView.transition(from: secondView, to: firstView, duration: 3, options: [.transitionCurlUp], completion: nil)
    }
        
    
   @IBAction func addView(_ sender: Any) {
        let width = Int(view.bounds.width / 10)
        let randx = Int(arc4random() % 10) * width
        let label = UILabel(frame: CGRect(x: randx, y: 0, width: width, height: width))
        label.backgroundColor = UIColor.red
        label.text = "A"
        label.textAlignment = .center
        view.addSubview(label)
        
        gravity.addItem(label)
        collision.addItem(label)
    }
    

    @IBAction func deleteView(_ sender: Any) {
        for item in self.view.subviews {
            if item is UILabel {
                item.removeFromSuperview()
                gravity.removeItem(item)
                collision.removeItem(item)
            }
        }
    }
    
    
    @IBAction func leftView(_ sender: Any) {
        gravity.gravityDirection = CGVector(dx: -1, dy: 0)
    }
    
    @IBAction func rightView(_ sender: Any) {
        gravity.gravityDirection = CGVector(dx: 1, dy: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    

}

