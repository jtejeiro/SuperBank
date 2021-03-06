//
//  CharactersDetailsViewController.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
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
    @IBOutlet var typeListLabel: [UILabel]!
    @IBOutlet var linkListLabel: [UIButton]!
    
    
    
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
    @objc func actionLink(_ sender: AnyObject){
        if let link:UIButton = sender as? UIButton {
            let urlString:String = link.titleLabel?.text ?? ""
            presenter?.onActionlink(title: viewModel.charactersDetails.name, urlString: urlString)
        }
    }
    
}

// MARK: - CharactersDetailsViewController
extension CharactersDetailsViewController: CharactersDetailsView {
    
    func showAlertError(title: String, message: String) {
        self.ShowAlert(title: title, message: message)
    }
    
    
    func showCharacters(CharactersVM: CharactersDetailsViewModel) {
        self.viewModel = CharactersVM
        configView()
    }
    
    
    
}
// MARK: - Private methods
private extension CharactersDetailsViewController {
    
    // MARK: - Setup
    func setupInit() {
        setupInitUrl()
    }
    
    func setupInitUrl(){
        for type in typeListLabel {
            type.text = ""
        }
        for link in linkListLabel {
            link.setTitle("", for: .normal)
            link.addTarget(self, action: #selector(self.actionLink(_:)), for: .touchUpInside)
        }
    }
    
    func configView() {
        self.navigationItem.title = viewModel.charactersDetails.name
        self.CharactersNameLabel.text = viewModel.charactersDetails.name
        self.CharactersDescriptionLabel.text = viewModel.charactersDetails.resultDescription
        self.charactersImageView.image = UIImage(named: "MarvelDefault")
        self.charactersImageView.contentMode = .scaleAspectFill
        self.changerUrlImg(urlimg: viewModel.urlImg)
        configViewUrl()
    }
    
    func configViewUrl(){
        for (index,elemet) in viewModel.listLink.enumerated() {
            self.typeListLabel[index].text = elemet.type
            self.linkListLabel[index].setTitle(elemet.url, for: .normal)
        }
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
