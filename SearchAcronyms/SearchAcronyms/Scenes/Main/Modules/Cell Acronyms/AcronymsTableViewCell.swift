//
//  AcronymsTableViewCell.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import UIKit

class AcronymsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lfLabel: UILabel!
    @IBOutlet weak var freqLabel: UILabel!
    @IBOutlet weak var sinceLabel: UILabel!
    @IBOutlet weak var lfVarLabel: UILabel!
    @IBOutlet weak var freqVarLabel: UILabel!
    @IBOutlet weak var sinceVarLabel: UILabel!
    
    
    static let reuseIdentifier = "AcronymsCell"
    static let cellHeight: CGFloat = 225

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Assigning values to cell data
    func configUI(acronyms: Lfs) {
        
        lfLabel.text = acronyms.lf
        freqLabel.text = String(acronyms.freq ?? 0)
        sinceLabel.text = String(acronyms.since ?? 0)
        lfVarLabel.text = acronyms.vars?[0].lf
        freqVarLabel.text = String(acronyms.vars?[0].freq ?? 0)
        sinceVarLabel.text = String(acronyms.vars?[0].since ?? 0)
    }
    
}
