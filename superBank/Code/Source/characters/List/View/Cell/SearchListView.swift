//
//  SearchListView.swift
//  superBank
//
//  Created by JT on 13/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import UIKit

protocol SearchListDelegate {
    func searchBarButtonClicked(text:String)
}

class SearchListView: UIView, XibInstantiatable {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate:SearchListDelegate?
    
    //MARK: - View INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiate()
        setupInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiate()
        setupInit()
    }
    
    //  setupInit
    func setupInit() {
        self.searchBar.delegate = self
    }
    
    func cleanSearchbar() {
        searchBar.text = ""
    }
    
    func closekeyboard() {
          self.searchBar.endEditing(true)
    }
}


extension SearchListView: UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchBarButtonClicked(text: searchBar.text ?? "")
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBarButtonClicked(text: searchText)
    }
    
}
