//
//  LocalDataTableViewCell.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import UIKit

final class LocalDataTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(name: String) {
        titleLabel.text = name
    }
}
