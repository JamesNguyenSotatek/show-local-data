//
//  LocalDataCoordinator.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import UIKit

public class LocalData {
    
    public func show() {
        var rootViewController = UIWindow.keyWindow?.rootViewController
        while let controller = rootViewController?.presentedViewController {
            rootViewController = controller
        }
        
        let vc = LocalDataViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        rootViewController?.present(nav, animated: true)
    }
}
