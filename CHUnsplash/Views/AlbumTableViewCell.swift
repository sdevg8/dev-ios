//
//  albumTableViewCell.swift
//  CHUnsplash
//
//  Created by user on 14/03/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumTitleLabel: UILabel!
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ album:Albums) {
        albumTitleLabel.text = album.title
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
