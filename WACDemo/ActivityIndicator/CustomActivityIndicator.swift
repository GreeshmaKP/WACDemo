//
//  CustomActivityIndicator.swift
//  WACDemo
//
//  Created by Apple on 09/11/22.
//

import Foundation
import UIKit

class CustomActivityIndicator: UIViewController {
    
    static let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    static let container: UIView = UIView()
    static let loadingView: UIView = UIView()
    
    static func showActivityIndicator(uiView: UIView) {
        DispatchQueue.main.async {
            container.frame = uiView.frame
            container.center = uiView.center
        }
        container.backgroundColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 0.3)
        
        loadingView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 80, height: 80))
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red:44/255, green:44/255, blue:44/255, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        actInd.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40))
        actInd.style = UIActivityIndicatorView.Style.large
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        actInd.color = .white
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        DispatchQueue.main.async {
            uiView.addSubview(container)
        }
        actInd.startAnimating()
    }
    
    static func hideActivityIndicator(uiView: UIView) {
        container.removeFromSuperview()
        actInd.stopAnimating()
    }
    
}
