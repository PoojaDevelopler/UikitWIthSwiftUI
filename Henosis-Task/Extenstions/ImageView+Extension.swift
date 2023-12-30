//
//  ImageView+Extension.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import UIKit
import Kingfisher


extension UIImageView{
    func setImage(with imageString:String){
        guard let url = URL.init(string: imageString) else{
            return
        }
        
        let resource = KF.ImageResource(downloadURL: url, cacheKey: imageString)
        kf.indicatorType =  .activity
        kf.setImage(with: resource)
    }
    
}
