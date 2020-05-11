//
//  CharactersDetailsViewController.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class CharactersDetailsViewController: BaseViewController {
    
    
    // MARK: - Properties
    var presenter: CharactersDetailsPresenter?
    
    // MARK: - Outlets
    @IBOutlet weak var charactersImageView: UIImageView!
    @IBOutlet weak var CharactersNameLabel: UILabel!
    @IBOutlet weak var CharactersDescriptionLabel: UILabel!
    
    
    
    // MARK: Private
    private var viewModel:CharactersDetailsViewModel!
    
    
    
    //MARK: - View Life Cycle Methods.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        setupInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.viewDidAppear()
    }
    
    
    // MARK: - override BaseView
    func backView(_ sender: Any?) {
        view.endEditing(true)
        presenter?.userClickGoBack()
    }
    
    // MARK: IBActions
    
}

// MARK: - CharactersDetailsViewController
extension CharactersDetailsViewController: CharactersDetailsView {
    
    func showCharacters(CharactersVM: CharactersDetailsViewModel) {
        self.viewModel = CharactersVM
        configView()
    }
    
    
    
}
// MARK: - Private methods
private extension CharactersDetailsViewController {
    
    // MARK: - Setup
    func setupInit() {
        /*
         title = GMLanguage.get("page_title")
         let backItem = UIBarButtonItem(image: UIImage(named: "bt_back"), style: .plain, target: self, action: #selector(clickBackBt))
         navigationItem.leftBarButtonItem = backItem
         */
    }
    
    func configView() {
        self.navigationItem.title = viewModel.charactersDetails.name
        self.CharactersNameLabel.text = viewModel.charactersDetails.name
        self.CharactersDescriptionLabel.text = viewModel.charactersDetails.resultDescription
        changerUrlImg(urlimg: viewModel.urlImg)
    }
    
    func changerUrlImg(urlimg:String){
        let urlImgLink = URL(string: urlimg)
        
        self.charactersImageView.sd_setImage(with: urlImgLink, placeholderImage: UIImage(named: "MarvelDefault"), completed: { image, error, cacheType, imageURL in
            if image != nil {
                self.charactersImageView.contentMode = .scaleAspectFill
            }
        })
    }
    
}
