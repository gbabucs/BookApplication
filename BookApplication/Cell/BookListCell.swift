//
//  BookListCell.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import UIKit
import MapleBacon

class BookListCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var previewImage: UIImageView!
    
    //MARK: Properties
    
    var onPressed: ExecutionBlock?
    
    var isReaded: Bool = false {
        didSet {
            if isReaded {
                statusButton.setTitle("Readed", for: .normal)
            } else {
                statusButton.setTitle("Pending", for: .normal)
            }
        }
    }
    
    //MARK: Static
    
    static let identifier = "BookListCell"
    
    //MARK: Actions
    
    @IBAction func statusButtonPressed(_ sender: Any) {
        guard let block = onPressed else {
            return
        }
        
        DispatchQueue.main.async {
            block()
        }
    }
    
    //MARK: Functions
    
    /**
     Configure cell
     - parameters:
     - for: BookListItem
     */
    
    func configureCell(for data: BookListItem) {
        title.text = data.title
        isReaded = data.isReaded
        previewImage.setImage(withUrl: data.url)
    }
    
    //MARK: UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
