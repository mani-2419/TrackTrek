//
//  ActivitySummaryTableView+Delegate.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 29/04/25.
//

import Foundation
import UIKit

extension ActivitySummaryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.activitySummaryTVC, for: indexPath) as! ActivitySummaryTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
