//
//  ProductListTableViewCell.swift
//  MVVMPracticePrejoct
//
//  Created by Digitalflake on 23/01/25.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productBackGraoundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var productDiscriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    var product : Product? {
        didSet { //Property Observer
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        productBackGraoundView.clipsToBounds = false
        productBackGraoundView.layer.cornerRadius = 15
        
       
        productImageView.layer.cornerRadius = 10
        self.productBackGraoundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func productDetailConfiguration(){
        guard let prodcut = product else { return }
        productTitleLabel.text = prodcut.title
        productCategoryLabel.text = "\(prodcut.category)"
        rateButton.setTitle("\(prodcut.rating.rate)", for: .normal)
        productDiscriptionLabel.text = prodcut.description
        priceLabel.text = "$\(prodcut.price)"
        productImageView.setImage(urlString: prodcut.image)
    }
}
