//
//  MainViewController.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displaySearchAcronyms(viewModel: Main.SearchAcronyms.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: Main.Error.ViewModel, on queu: DispatchQueue)
}

class MainViewController: BaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var acronymsTableView: UITableView!
    @IBOutlet weak var defaultView: SAView!
    
    let cellAcronymsNibName = "AcronymsTableViewCell"
    
    var dataAcronym : [Lfs]?
    
    var filteredAcronym : [Lfs] = [] {
        didSet {
            acronymsTableView.reloadData()
        }
    }
    
    var isSearching = false
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInitialData()
        settingTableView()
        self.navigationController?.clearBackground()
        searchBar.delegate = self
        acronymsTableView.delegate = self
        acronymsTableView.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        refresher.endRefreshing()
        isSearching = false
    }
    
    // Request service searchAcronyms
    func searchAcronyms(word: String){
        hideLoading()
        let request = Main.SearchAcronyms.Request(sf: word)
        interactor?.searchAcronyms(request: request)
    }
    
    // Configure CellView in MainViewController
    private func settingTableView() {
        acronymsTableView.register(UINib(nibName: cellAcronymsNibName, bundle: nil),
                           forCellReuseIdentifier: AcronymsTableViewCell.reuseIdentifier)
        
        acronymsTableView.refreshControl = refresher
    }
    
    // Begin Editing SearchBar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
    }
    
    // End Editing SearchBar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        isSearching = false
        searchBar.text = ""
        acronymsTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    // Hide Keyboard on tap screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // Dismiss Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

// MARK: - MainDisplayLogic
extension MainViewController: MainDisplayLogic {
    func displaySearchAcronyms(viewModel: Main.SearchAcronyms.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        filteredAcronym.removeAll()
        if viewModel.data.count > 0 {
            view.endEditing(true)
            defaultView.isHidden = true
            dataAcronym = viewModel.data[0].lfs
            
            refresher.endRefreshing()
            acronymsTableView.reloadData()
        }
    }
    
    func displayError(viewModel: Main.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    // Show rows of the table depend status variable bool
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            if filteredAcronym.isEmpty {
                return 0
            } else {
                return filteredAcronym.count
            }
        } else {
            return dataAcronym?.count ?? 0
        }
    }
    
    // Show cells of the table depend status variable bool
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AcronymsTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? AcronymsTableViewCell else {
                                                        fatalError()
        }

        if isSearching {
            if filteredAcronym.isEmpty {
                return cell
            } else {
                cell.configUI(acronyms: filteredAcronym[indexPath.row])
            }
        } else {
            cell.configUI(acronyms: (dataAcronym?[indexPath.row])!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AcronymsTableViewCell.cellHeight
    }
}

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchBarDelegate {
    
    // Actions search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        if !searchText.isEmpty {
            searchAcronyms(word: searchText.lowercased())
            showLoading()
        } else {
            dataAcronym?.removeAll()
            acronymsTableView.reloadData()
            defaultView.isHidden = false
        }
    }
    
    // Actions cancel button searchBar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        isSearching = false
        searchBar.text = ""
        acronymsTableView.reloadData()
        searchBar.resignFirstResponder()
        defaultView.isHidden = false
        filteredAcronym.removeAll()
    }
}
