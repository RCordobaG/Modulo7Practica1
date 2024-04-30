//
//  NoteCell.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation
import UIKit

class NoteCell: UITableViewCell {


    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteBody: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    
    @IBOutlet weak var notePriority: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
