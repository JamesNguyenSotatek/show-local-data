//
//  LocalDataViewController.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import UIKit
import KeychainAccess

final class LocalDataViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    private var menuButtonItem = UIBarButtonItem()
    
    //MARK: - Properties
    private var dataSources = [LocalDataType]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setupTableView()
        initDatas()
    }
    
    private func initNavigationBar() {
        title = "Local Data"
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(closeAction))
        navigationItem.leftBarButtonItem = closeButton
        creatMenuBar()
    }
    
    private func creatMenuBar() {
        let addSuiteNameImageView = UIImage(systemName: "pencil.line")?.withTintColor(.orange,
                                                                                      renderingMode: .alwaysOriginal)
        let addSuiteNameAction = UIAction(title: "Add SuiteName for UserDefaults",
                                          image: addSuiteNameImageView,
                                          state: .mixed) { _ in
            let alert = UIAlertController(title: "Add SuiteName for UserDefaults", message: nil, preferredStyle: .alert)
            alert.addTextField { text in
                text.placeholder = "service"
            }
            alert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                let text = alert.textFields?[0].text ?? ""
                if !text.isEmpty {
                    self.dataSources.append(.userDefaults(item: .suiteName(name: text,
                                                                           items: self.getAllDataUserDefault(type: .suiteName(name: text,
                                                                                                                              items: [])))))
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        let addKeychainImage = UIImage(systemName: "pencil.line")?.withTintColor(.red,
                                                                                 renderingMode: .alwaysOriginal)
        let addKeychainAction = UIAction(title: "Add Keychain service",
                                         image: addKeychainImage,
                                         state: .mixed) { _ in
            let alert = UIAlertController(title: "Add new SuiteName for UserDefaults", message: nil, preferredStyle: .alert)
            alert.addTextField { text in
                text.placeholder = "SuiteName"
            }
            alert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                let text = alert.textFields?[0].text ?? ""
                if !text.isEmpty {
                    self.dataSources.append(.keychain(item: .service(name: text,
                                                                     items: self.getAllDataKeychain(type: .service(name: text,
                                                                                                                   items: [])))))
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        let menu = UIMenu(children: [addSuiteNameAction, addKeychainAction])
        menuButtonItem.menu = menu
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"))
        self.navigationItem.rightBarButtonItem?.menu = menu
    }
    
    @objc func closeAction() {
        dismiss(animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: LocalDataTableViewCell.self)
    }
}

private extension LocalDataViewController {
    
    func initDatas() {
        let userDefaultsAllData = getAllDataUserDefault(type: .standard(items: []))
        dataSources.append(.userDefaults(item: .standard(items: userDefaultsAllData)))
        
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        let keychainAllData = getAllDataKeychain(type: .service(name: bundleId, items: []))
        dataSources.append(.keychain(item: .service(name: bundleId, items: keychainAllData)))
        
        let userDefaultsSuiteNameAllData = getAllDataUserDefault(type: .suiteName(name: "TestSuiteName", items: []))
        
        dataSources.append(.userDefaults(item: .suiteName(name: "TestSuiteName", items: userDefaultsSuiteNameAllData)))
    }
    
    func getAllDataUserDefault(type: UserDefaultType) -> [DetailValue] {
        switch type {
        case .standard:
            return UserDefaults.standard.dictionaryRepresentation().map { .init(key: $0.key, value: $0.value)}
        case let .suiteName(name, _) :
            return UserDefaults(suiteName: name)?.dictionaryRepresentation().map { .init(key: $0.key, value: $0.value) } ?? []
        }
    }
    
    func getAllDataKeychain(type: KeychainType) -> [DetailValue] {
        switch type {
        case let .service(name, _):
            return Keychain(service: name).allItems().map { .init(key: $0["key"] as? String ?? "",
                                                                  value: $0["value"] ?? "") }
        }
    }
    
}

extension LocalDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSources[indexPath.row]
        let vc = DetailViewController(dataSource: data.items,
                                      title: data.description)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LocalDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(LocalDataTableViewCell.self)
        cell.configCell(name: dataSources[indexPath.row].description)
        return cell
    }
}
