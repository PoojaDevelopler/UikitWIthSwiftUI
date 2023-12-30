//
//  CocktailListVC.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import UIKit
import SwiftUI


class CocktailListVC: UIViewController {

    @IBOutlet weak var productTV:UITableView!{
        didSet{
            productTV.dataSource = self
            productTV.delegate = self
        }
    }
    @IBOutlet weak var segmentControl: UISegmentedControl!

    
    private var viewModel = CocktailViewModel()
    private var cocktailModel: [CocktailModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }

}


extension CocktailListVC{
    
    func configuration(){
        productTV.register(UINib(nibName: "CocktailCell", bundle: nil), forCellReuseIdentifier: "CocktailCell")
        segmentControl.accessibilityIdentifier = "MyCocktailFilterIdentifier"
        productTV.accessibilityIdentifier = "MyCocktailTableIdentifier"
        
        initViewModel()
    }
    
    func initViewModel() {
        observeEvent()
        viewModel.productFeatch()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loading: break // Show loading indicator
            case .dataLoading:
                viewModel.filterCocktails(forSegmentIndex: segmentControl.selectedSegmentIndex)
                reloadTableView()
            case .error(let error):
                print(error)
            }
        }
    }
    
}


//MARK: Table delegate
extension CocktailListVC:UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath) as! CocktailCell
        
        cell.cocktailData = self.cocktailModel[indexPath.row]
        
        //weak self in clouser to avoid retain cycle.
        cell.detailActionHandler = { [weak self] in
            guard let self = self else { return }
            
            let selectedCocktail = self.cocktailModel[indexPath.row]
            
            let swiftUIView = CocktailDetailView(cocktail: selectedCocktail)
            let hostingController = UIHostingController(rootView: swiftUIView)
            
            // Present the SwiftUI view when a cell is selected
            navigationController?.pushViewController(hostingController, animated: true)
            
        }
       
        cell.fullIngredientsActionHandler = { [weak self] in
            guard let self = self else { return }
            let selectedCocktail = self.cocktailModel[indexPath.row]
            let swiftUIView = IngridientList(cocktailList: selectedCocktail.ingredients, cocktailName: selectedCocktail.name)
            let hostingController = UIHostingController(rootView: swiftUIView)
            navigationController?.pushViewController(hostingController, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
}


extension CocktailListVC{
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.filterCocktails(forSegmentIndex: sender.selectedSegmentIndex)
        reloadTableView()
    }
    
    
    func reloadTableView() {
        cocktailModel = viewModel.getFilteredCocktails()
        productTV.reloadData()
    }
}
