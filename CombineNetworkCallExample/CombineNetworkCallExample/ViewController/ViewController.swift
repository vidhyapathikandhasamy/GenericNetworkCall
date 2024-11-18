//
//  ViewController.swift
//  CombineNetworkCallExample
//
//  Created by Vidhyapathi on 17/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoTableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var studentViewModel = StudentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLoader()
        self.fetchUser()
    }
    
    func setupTableView() {
        self.infoTableView.dataSource = self
        self.infoTableView.delegate = self
        self.infoTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
    }
    
    func setupLoader() {
        // Initialize the activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center // Position it in the center of the screen
        activityIndicator.hidesWhenStopped = true // Hide it when it's not animating
        view.addSubview(activityIndicator)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = studentViewModel.userList?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell {
            if let userList = studentViewModel.userList {
                cell.upateInfoCell(userList: userList[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - API Call
extension ViewController {
    func fetchUser() {
        showLoader()
        studentViewModel.fetchUserInfo { [weak self] error in
            DispatchQueue.main.async {
                self?.hideLoader()
                if let error {
                    print(error)
                }
                self?.infoTableView.reloadData()
            }
        }
    }
}

//MARK: - Loader Extension
extension ViewController {
    // Function to show the loader
    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    // Function to hide the loader
    func hideLoader() {
        activityIndicator.stopAnimating()
    }
}
