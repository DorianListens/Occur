//
//  OccurenceTableViewController.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-17.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import UIKit

class OccurenceTableViewController: UITableViewController {
    var occurences = [Occurence]()
    var repo: OccurenceRepo = OccurenceRepo()
    var thing: Thing? {
        didSet {
            if let thing = thing {
                occurences = repo.forThing(thing)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let t = thing {
            occurences = repo.forThing(t)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        guard let thing = thing else { return }

        let newOccurence = repo.save(Occurence(thing: thing))
        occurences.insert(newOccurence, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return occurences.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OccurenceCell", for: indexPath)

        let occurence = occurences[indexPath.row]
        cell.textLabel!.text = occurence.date.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            occurences.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
