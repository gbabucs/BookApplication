//
//  BookDetailViewController.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import UIKit
import MapleBacon

public typealias ExecutionBlock = (() -> ()?)

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textSnippetLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: Properties
    
    var bookDetails: BookDetailItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        guard let bookInfo = bookDetails else {
            return
        }
        
        imageView.setImage(withUrl: bookInfo.url)
        titleLabel.text = bookInfo.title
        authorsLabel.text = bookInfo.authors
        subtitleLabel.text = bookInfo.subtitle
        ratingLabel.text = "Average Rating: \(bookInfo.rating)"
        
        let subtitleHeight = subtitleLabel.optimalHeight
        
        subtitleLabel.frame = CGRect(x: subtitleLabel.frame.origin.x, y: subtitleLabel.frame.origin.y, width: subtitleLabel.frame.width, height: subtitleHeight)
        subtitleLabel.sizeToFit()
    }
    
}
