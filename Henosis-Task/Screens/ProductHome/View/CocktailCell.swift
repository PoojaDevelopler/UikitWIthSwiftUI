//
//  CocktailCell.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import UIKit

class CocktailCell: UITableViewCell {

    @IBOutlet weak var cocktailTitle:UILabel!
    @IBOutlet weak var cocktailCategory:UILabel!
    @IBOutlet weak var cocktailRateButton:UIButton!
    @IBOutlet weak var cocktailShortDescription:UILabel!
    @IBOutlet weak var cocktailImage:UIImageView!
    
    var detailActionHandler: (() -> Void)?
    var fullImageActionHandler: (() -> Void)?
    var fullIngredientsActionHandler: (() -> Void)?
    
    
    //prperty observer
    var cocktailData:CocktailModel?{
        didSet{
            cocktailDetailsConfiguaration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func detailsAction(_ sender:UIButton){
        detailActionHandler?()

    }
    
    @IBAction func ingredientsAction(_ sender:UIButton){
        fullIngredientsActionHandler?()
    }
    
}


extension CocktailCell{
    func cocktailDetailsConfiguaration(){
        guard let cocktailData else {
            return
        }
        cocktailTitle.text = cocktailData.name
        cocktailCategory.text = cocktailData.type.rawValue
        cocktailShortDescription.text = cocktailData.shortDescription
        cocktailRateButton.setTitle("Prepration Time: \(cocktailData.preparationMinutes) Min", for: .normal)
        cocktailImage.setImage(with: cocktailData.imageName)
    }
}


