//
//  CharactersListViewCell.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit
import SDWebImage

class CharactersListViewCell: UITableViewCell {
    
    static let identifier = "CharactersListViewCell"
    
    @IBOutlet weak var charactersImageView: UIImageView!
    @IBOutlet weak var CharactersLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(name:String,thumbnail:Thumbnail){
        self.CharactersLabel.text = name
        changerUrlImg(urlimg: thumbnail)
    }
    
}
extension CharactersListViewCell {
    
    func changerUrlImg(urlimg:Thumbnail){
        let urlString:String = urlimg.path + "." + urlimg.thumbnailExtension.rawValue
        let urlImgLink = URL(string: urlString)

        self.charactersImageView.sd_setImage(with: urlImgLink, placeholderImage: UIImage(named: "MarvelDefault"), completed: { image, error, cacheType, imageURL in
            if image != nil {
                self.charactersImageView.contentMode = .scaleAspectFill
            }
        })
    }
    
}
