//
//  CharactersListViewCell.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import UIKit
import SDWebImage

class CharactersListViewCell: UITableViewCell {
    
    static let identifier = "CharactersListViewCell"
    
    @IBOutlet weak var charactersImageView: UIImageView!
    @IBOutlet weak var CharactersLabel: UILabel!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(name:String,thumbnail:Thumbnail?){
        self.CharactersLabel.text = name
        if thumbnail != nil {
            changerUrlImg(urlimg: thumbnail ?? Thumbnail(path: "", thumbnailExtension: ""))
        }else {
            self.charactersImageView.image = UIImage(named: "MarvelDefault")
            self.charactersImageView.contentMode = .scaleAspectFill
        }
    }
    
}
extension CharactersListViewCell {
    
    func changerUrlImg(urlimg:Thumbnail){
        self.loadingActivity.startAnimating()
        
        let urlString:String = urlimg.path + "." + urlimg.thumbnailExtension
        let urlImgLink = URL(string: urlString)
        self.charactersImageView.contentMode = .scaleAspectFill
        self.charactersImageView.sd_setImage(with: urlImgLink, placeholderImage: UIImage(named: "MarvelDefault"), completed: { image, error, cacheType, imageURL in
            self.loadingActivity.stopAnimating()
            self.loadingActivity.isHidden = true
            if image != nil {
                self.charactersImageView.contentMode = .scaleAspectFill
            }
        })
    }
    
}
