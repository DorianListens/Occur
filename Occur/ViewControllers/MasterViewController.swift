//
//  MasterViewController.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-17.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {

    var detailViewController: DetailViewController? = nil
    let thingsRepo = ThingsRepo()
    let oRepo = OccurrenceRepo()
    var things: [Thing] {
        return thingsRepo.all()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewThing(_ thing: Thing) {
        let _ = thingsRepo.save(thing)
        collectionView?.reloadData()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThing" {
            if let indexPath = self.collectionView?.indexPathsForSelectedItems?.first {
                let thing = things[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.repo = oRepo
                controller.detailItem = thing
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }

        if segue.identifier == "createThing" {
        }
    }

    // MARK: - CollectionView
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return things.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThingCell", for: indexPath) as! ThingCell

        let thing = things[indexPath.row]
//        cell.textLabel!.text = thing.description
        cell.imageView?.image = thing.image
        cell.backgroundColor = .black
        return cell
    }
}

class ThingCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

}

