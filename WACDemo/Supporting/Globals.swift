//
//  Globals.swift
//  WACDemo
//
//  Created by Apple on 09/11/22.
//

import Foundation
import UIKit


extension UITextField {
    
    func addLeftIcon() {
        let paddingView = UIView(
            frame: CGRect.init(
                x: 0.0,
                y: 0.0,
                width: 35.0,
                height: self.frame.height
            )
        )
        let imageView = UIImageView(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: 20.0,
                height: 20.0
            )
        )
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.center = paddingView.center
        imageView.tintColor = UIColor.lightGray
        paddingView.addSubview(imageView)
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func addRightIcon() {
        let paddingView = UIView(
            frame: CGRect.init(
                x: self.frame.width - 35.0,
                y: 0.0,
                width: 35.0,
                height: self.frame.height
            )
        )
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        paddingView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor, constant: 5.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor, constant: -5.0).isActive = true
        imageView.topAnchor.constraint(equalTo: paddingView.topAnchor, constant: 5.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: paddingView.bottomAnchor, constant: -5.0).isActive = true
        imageView.image = UIImage(systemName: "barcode.viewfinder")
        imageView.center = paddingView.center
        imageView.tintColor = UIColor.lightGray
        self.rightView = paddingView
        self.rightViewMode = UITextField.ViewMode.always
    }
    
    
    
}
