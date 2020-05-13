//
//  SearchHeaderListViewCell.swift
//  superBank
//
//  Created by Jaime Tejeiro on 13/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit

protocol SearchHeaderListDelegate {
    func searchBarButtonClicked(text:String)
}

class SearchHeaderListViewCell: UITableViewCell {
    
    static let identifier = "SearchHeaderListViewCell"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate:SearchHeaderListDelegate?
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: self.identifier , bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.searchBar.delegate = self
    }
    
}
extension SearchHeaderListViewCell: UISearchBarDelegate{
     
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchBarButtonClicked(text: searchBar.text ?? "")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        delegate?.searchBarButtonClicked(text: searchBar.text ?? "")
    }

}
