//
//  ActivitySummaryVC.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 24/04/25.
//

import UIKit

class ActivitySummaryVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        GlobalHelper.setBackgroundImage(view)
    }
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: CellIdentifier.activitySummaryTVC, bundle: nil), forCellReuseIdentifier: CellIdentifier.activitySummaryTVC)
    }
}
