//
//  ActivitySummaryTableViewCell.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 29/04/25.
//

import UIKit

class ActivitySummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyShadow()
        backView.setCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
