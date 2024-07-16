//
//  BottomSheetViewController.swift
//  Full-View-With-TableView
//
//  Created by Muhammad Rajab on 16-07-2024.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var bottomSheetView: UIView!

    // define a variable to store initial touch position
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    internal var overlayViewCallback: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // works without the tap gesture just fine (only dragging), but I also wanted to be able to tap anywhere and dismiss it, so I added the gesture below
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapOutsideBottomSheet(_:)))
        self.backgroundView.addGestureRecognizer(tap)
        
        let swipeDown = UIPanGestureRecognizer(target: self, action: #selector(self.handleSwipeBottomSheet(_:)))
        self.bottomSheetView.addGestureRecognizer(swipeDown)
        
        self.bottomSheetView.layer.cornerRadius = 20
        self.bottomSheetView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
    }
}

extension BottomSheetViewController {
    @objc func handleTapOutsideBottomSheet(_ sender: UITapGestureRecognizer) {
        overlayViewCallback?()
        dismiss(animated: true, completion: nil)
    }

    //source: https://medium.com/@qbo/dismiss-viewcontrollers-presented-modally-using-swipe-down-923cfa9d22f4
    @IBAction func handleSwipeBottomSheet(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)

        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                overlayViewCallback?()
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
}
