//
//  Loader.swift
//  ProjectF02
//
//  Created by Quang Thai on 11/29/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation
import UIKit
final class Loader: UIView {
    
    // MARK: - Share Instance
    static let shared = Loader()
    
    // MARK: - Function
    func show() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .colorFromHex("000000", alpha: 0.5)
//        let activityView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80),
//                                                   type: .ballScaleMultiple,
//                                                   color: .white)
        let activityView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityView.center = view.center
        activityView.startAnimating()
        view.addSubview(activityView)
        self.addSubview(view)
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    func dismiss() {
        for subview in self.subviews {
            if let activityView = subview as? UIActivityIndicatorView {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            } else {
                subview.removeFromSuperview()
            }
        }
        self.removeFromSuperview()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }
}
