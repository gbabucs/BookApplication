//
//  BookListViewController.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/16/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    
    var dataSource: BookListDataSource?
    var listOfBooks: APIBooks?
    var selectedBookDetail: BookDetailItem?
    
    //MARK: Functions
    
    func setup(){
        title = "Books"
        
        let topRated = UIBarButtonItem(title: "All", style: .plain, target: self, action: #selector(showAllItems))
        let advanceFilter = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showActionSheet))
        
        navigationItem.rightBarButtonItem = topRated
        navigationItem.leftBarButtonItem = advanceFilter
        tableView.tableFooterView = UIView()
    }
    
    func setupEvents() {
        dataSource?.onUpdated = {
            self.tableView.reloadData()
        }
    }
    
    //MARK: Helpers
    
    private func readJSON(){
        ServiceManager.getBook(for: "") { error, books in
            if let books = books {
                self.listOfBooks = books
                self.dataSource = BookListDataSource(data: books)
            }
        }
    }
    
    //MARK: Actions
    
    @objc
    func showActionSheet() {
        let alertViewController = UIAlertController(title: "", message: "Choose Fileter", preferredStyle: .actionSheet)
        let topRatedAction = UIAlertAction(title: "Top rated", style: .default) { _ in
            self.filterWithTopRated()
        }
        let readingAction = UIAlertAction(title: "Readed", style: .default) { _ in
            self.showReadedItems()
        }
        let pendingAction  = UIAlertAction(title: "Pending", style: .default) { _ in
            self.showPendingItems()
        }
        
        alertViewController.addAction(topRatedAction)
        alertViewController.addAction(readingAction)
        alertViewController.addAction(pendingAction)
        alertViewController.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        
        present(alertViewController, animated: true, completion: nil)
    }
    
    func updateStatus(sender: Any?) {
        guard let cell = sender as? BookListCell,
            let indexPath = tableView.indexPath(for: cell),
            let item = dataSource?.item(at: indexPath)
            else {
                return
        }
        
        dataSource?.update(isReaded: !item.isReaded, at: indexPath, tableView: tableView)
    }
    
    // MARK - UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupEvents()
        readJSON()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetail" {
            guard let bookDetailViewController = segue.destination as? BookDetailViewController,
                let selectedBookDetail = selectedBookDetail else {
                    return
            }
            
            bookDetailViewController.bookDetails = selectedBookDetail
        }
    }
    
}

//MARK: UITableViewDataSource

extension BookListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let item = dataSource?.data else {
            return 0
        }
        
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListCell.identifier, for: indexPath) as? BookListCell,
            let dataSource = dataSource
            else {
                return UITableViewCell()
        }
        
        let item = dataSource.item(at: indexPath)
        
        cell.configureCell(for: item)
        cell.onPressed = { [weak self] in
            self?.updateStatus(sender: cell)
        }
        
        return cell
    }
    
}

//MARK: UITableViewDelegate

extension BookListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else {
            return
        }
        
        let item = dataSource.item(at: indexPath)
        
        selectedBookDetail = item.bookDetail
        
        performSegue(withIdentifier: "showBookDetail", sender: self)
    }
    
}

//MARK: Filters

extension BookListViewController {
    
    private func reset() {
        guard let books = listOfBooks else {
            return
        }
        
        dataSource = BookListDataSource(data: books)
    }
    
    @objc
    private func showAllItems() {
        reset()
        tableView.reloadData()
    }
    
    private func filterWithTopRated() {
        reset()
        guard let dataSource = dataSource else {
            return
        }
        
        dataSource.filterTopRatedItems()
        tableView.reloadData()
    }
    
    private func showReadedItems() {
        reset()
        guard let dataSource = dataSource else {
            return
        }
        
        dataSource.filterReading()
        tableView.reloadData()
    }
    
    private func showPendingItems() {
        reset()
        guard let dataSource = dataSource else {
            return
        }
        
        dataSource.filterPending()
        tableView.reloadData()
    }
    
}
