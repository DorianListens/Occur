//
//  ApplicationViewController.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-20.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import Foundation
import UIKit

class ApplicationController: UISplitViewControllerDelegate {

    let rootVC = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "RootSplitViewController") as! UISplitViewController

    var navigationController: UINavigationController {
        return rootVC.viewControllers.last as! UINavigationController
    }

    func setupViewControllers() {
        navigationController.topViewController?.navigationItem.leftBarButtonItem = rootVC.displayModeButtonItem
        rootVC.delegate = self
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }


}
