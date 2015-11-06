import UIKit

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    let objects = ComputerDataSource().computers
    var latestActivity: NSUserActivity?
    var computerToRestore: Computer?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let computer = computerToRestore {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = computer
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                computerToRestore = nil
            }
            else if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                latestActivity = updateIndexForComputer(object)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.shortDescription
        return cell
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        guard let name = activity.userInfo?["name"] as? String else {
            NSLog("I can't restore from this activity: \(activity)")
            return
        }
        let matches = ComputerDataSource().computers.filter {
            $0.shortDescription == name
        }
        if matches.count == 0 {
            NSLog("No computer matches name \(name)")
            return
        }
        self.computerToRestore = matches[0]
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
}
