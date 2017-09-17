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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    
    var dataSource: BookListDataSource?
    var listOfBooks: APIBooks?
    var selectedBookDetail: BookDetailItem?
    
    //MARK: Functions
    
    func setup(){
        title = "Books"
        
        let allItems = UIBarButtonItem(title: "All", style: .plain, target: self, action: #selector(showAllItems))
        let advanceFilter = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showActionSheet))
        
        view.endEditing(true)
        
        navigationItem.rightBarButtonItem = allItems
        navigationItem.leftBarButtonItem = advanceFilter
        tableView.tableFooterView = UIView()
    }
    
    func setupEvents() {
        dataSource?.onUpdated = {
            self.tableView.reloadData()
        }
    }
    
    //MARK: Helpers
    
    func performSearchWithText(searchText: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ServiceManager.shared.getBook(for: searchText) { error, books in
            self.hideIndicator()
            if error != nil {
                print(error.debugDescription)
            }
            else if let books = books {
                self.listOfBooks = books
                self.dataSource = BookListDataSource(data: books)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tableView.reloadData()
                })
                
            }
        }
    }
    
    //MARK: Actions
    
    @objc
    func showActionSheet() {
        let alertViewController = UIAlertController(title: "", message: "Choose Filter", preferredStyle: .actionSheet)
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
    
    func hideIndicator() {
        DispatchQueue.main.async(execute: { () -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }
    
    
    // MARK - UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupEvents()
        //"https://www.googleapis.com/books/v1/volumes?filter=free-ebooks&q=a"
        performSearchWithText(searchText: "a")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetail" {
            searchBar.resignFirstResponder()
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

// MARK: - UISearchBarDelegate

extension BookListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text,
            !text.isEmpty else {
                return
        }
        
        performSearchWithText(searchText: text)
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
        
        dataSource.filterReadingItems()
        tableView.reloadData()
    }
    
    private func showPendingItems() {
        reset()
        guard let dataSource = dataSource else {
            return
        }
        
        dataSource.filterPendingItems()
        tableView.reloadData()
    }
    
}

