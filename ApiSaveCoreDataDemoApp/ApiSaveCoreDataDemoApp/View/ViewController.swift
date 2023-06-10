//
//  ViewController.swift
//  ApiSaveCoreDataDemoApp
//
//  Created by CV on 6/8/23.
//

import UIKit

class ViewController: UIViewController, UpdateTableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var apiService = ApiService()
    private var viewModel = ListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        self.tableView.delegate = self

        self.tableView.dataSource = self
        self.viewModel.delegate = self
        self.tableView.register(UINib(nibName: "listTableViewCell", bundle: nil), forCellReuseIdentifier: "listTableViewCell")
        loadPopularMoviesData()
        loadData()
        
    }
    private func loadPopularMoviesData() {
        apiService.getPopularMoviesData { [weak self] (result) in
            switch result {
            case .success(let listOf):
                // Save data to Core Data
                CoreData.sharedInstance.saveDataOf(movies: result as? [Unicorns] ?? [])
                self?.tableView.reloadData()
            case .failure(let error):
                // Show alert message in case of error
                self?.showAlertWith(title: "Could Not Connect!", message: "Please check your internet connection \n or try again later")
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    private func loadData() {
        viewModel.retrieveDataFromCoreData()
    }
    
    // Update the tableView if changes have been made
    func reloadData(sender: ListViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
    }
    
  
    //MARK: - Navigation Bar appearance
    private func setNavigationBar() {
        // Transparent the navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Navigation bar item color (time, battery) - white
        self.navigationController?.navigationBar.barStyle = .black
    }
}

//MARK: - TableView
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell", for: indexPath)
        
        let object = viewModel.object(indexPath: indexPath)
        
//        if let movieCell = cell as? listTableViewCell {
//            if let movie = object {
//                movieCell.setCellWithValuesOf(movie)
//            }
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedMovie = viewModel.object(indexPath: indexPath)
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
//        vc?.viewModel = MovieDetailsViewModel(movieDetails: selectedMovie)
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    // MARK: - Alert message
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

