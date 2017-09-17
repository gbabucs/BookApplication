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
    
    //MARK: Functions
    
    func configureView() {
        guard let bookInfo = bookDetails else {
            return
        }
        
        let subtitleHeight = subtitleLabel.optimalHeight
        
        imageView.setImage(withUrl: bookInfo.url)
        titleLabel.text = bookInfo.title
        authorsLabel.text = bookInfo.authors
        subtitleLabel.text = bookInfo.subtitle
        ratingLabel.text = "Average Rating: \(bookInfo.rating)"
        subtitleLabel.frame = CGRect(x: subtitleLabel.frame.origin.x, y: subtitleLabel.frame.origin.y, width: subtitleLabel.frame.width, height: subtitleHeight)
        subtitleLabel.sizeToFit()
    }
    
    func setupView(){
        let previewButton = UIBarButtonItem(title: "Preview", style: .plain, target: self, action: #selector(previewAction))
        
        navigationItem.rightBarButtonItem = previewButton
    }
    
    //MARK: Actions
    
    @objc
    private func previewAction(){
        guard let bookInfo = bookDetails else {
            return
        }
        
        performSegue(withIdentifier: "showBookPreview", sender: bookInfo)
    }
    
    
    // MARK - UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureView()
    }
    
    // MARK - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookPreview" {
            guard let previewNavigationController = segue.destination as? UINavigationController,
                let bookPreviewViewController = previewNavigationController.viewControllers.first as? BookPreviewViewController,
                 let previewUrl = bookDetails?.previewUrl
            else {
                    return
            }
            
            bookPreviewViewController.previewUrl = previewUrl
        }
    }
    
}
