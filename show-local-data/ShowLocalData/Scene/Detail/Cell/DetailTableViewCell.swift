//
//  DetailTableViewCell.swift
//  show-local-data
//
//  Created by Thân Văn Thanh on 06/12/2023.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    
    private var data: DetailValue?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(_ data: DetailValue) {
        titleLabel.text = data.displayText
        self.data = data
    }
    
    @IBAction func coppyAction(_ sender: Any) {
        UIPasteboard.general.string = data?.displayText ?? ""
    }
    
}
