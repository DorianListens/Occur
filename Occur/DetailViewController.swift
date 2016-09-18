//
//  DetailViewController.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-17.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var repo: OccurenceRepo = OccurenceRepo() {
        didSet {
            updateRepoRef()
        }
    }

    let tvc = OccurenceTableViewController()

    var detailItem: Thing? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func updateRepoRef() {
        tvc.repo = repo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = tvc
        tableView.dataSource = tvc
        tvc.tableView = tableView
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: tvc, action: #selector(tvc.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            tvc.thing = detail
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

