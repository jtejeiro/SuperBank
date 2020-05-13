//
//  CharactersListViewController.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit
import Foundation


class CharactersListViewController: BaseViewController {
    
    
    // MARK: - Properties
    var presenter: CharactersListPresenter?
    
    // MARK: - Outlets
    @IBOutlet private var tableView:UITableView!
    @IBOutlet private var ordenByNameButton:UIButton!
    @IBOutlet private var ordenByModifiedButton:UIButton!
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: Private
    private var viewModel:CharactersListViewModel!
    var onActionRefresh:Bool = false
    
    
    
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
        configView()
    }
    
    
    // MARK: - override BaseView
    func backView(_ sender: Any?) {
        view.endEditing(true)
        presenter?.userClickGoBack()
    }
    
    // MARK: IBActions
    
    @IBAction func actionOrderByName(_ sender: Any) {
        self.emptyView.isHidden = false
        self.presenter?.onActionOrdenByName()
        self.actionRefreshOrdenBy()
    }
    
    @IBAction func actionOrderByModified(_ sender: Any) {
        self.emptyView.isHidden = false
        self.presenter?.onActionOrdenByModified()
        self.actionRefreshOrdenBy()
    }
    
}

// MARK: - CharactersListViewController
extension CharactersListViewController: CharactersListView {
    
    func showCharacters(CharactersVM:CharactersListViewModel){
        self.viewModel = CharactersVM
        showEmptyView()
        tableView.reloadData()
        onActionRefresh = true
    }
    
    func showAlertError(title:String,message:String){
        self.ShowAlert(title: title, message: message)
        showEmptyView()
    }
}
// MARK: - Private methods
private extension CharactersListViewController {
    
    // MARK: - Setup
    func setupInit() {
        self.navigationItem.title = "characters"
        self.emptyView.isHidden = false
    }
    
    func configView() {
        onActionRefresh = true
        configTableView()
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CharactersListViewCell.identifier , bundle: nil), forCellReuseIdentifier: CharactersListViewCell.identifier)
    }
    
    func actionRefresh(indexCell:Int){
        if onActionRefresh {
            if indexCell > self.viewModel.charactersList.count - 4 {
                print(self.viewModel.charactersList.count)
                self.onActionRefresh = false
                presenter?.moreRefreshCharactersList()
            }
        }
    }
    
    func actionRefreshOrdenBy(){
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            self.tableView.setContentOffset(.zero, animated: false)
        }
    }
    
    func showEmptyView(){
        if viewModel.charactersList.count == 0{
            self.emptyView.isHidden = false
        }else {
            self.emptyView.isHidden = true
        }
    }
    
}
extension CharactersListViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListViewCell.identifier, for: indexPath) as? CharactersListViewCell else{
            return CharactersListViewCell()
        }
        
        let type = viewModel.charactersList[indexPath.row]
        cell.setupCell(name: type.name, thumbnail: type.thumbnail)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         presenter?.didSelectRowAt(index: indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        actionRefresh(indexCell: indexPath.row)
    }

}
