//
//  CreatDataViewController.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import UIKit
import KeychainAccess

class CreatDataViewController: UIViewController {
    
    private let stringValue = "test"
    private let boolValue = true
    private let intValue = 1
    private let doubleValue = 1.1
    private let floatValue: Float = 1.1
    private let urlValue = URL(string: "https://github.com/JamesNguyenSotatek")
    private let string = "Test save String Test save String Test save String Test save String Test save String"

    override func viewDidLoad() {
        super.viewDidLoad()

        let suiteName = UserDefaults(suiteName: "TestSuiteName")
        suiteName?.set(string, forKey: "string")
        suiteName?.set(stringValue, forKey: "stringTest")
        suiteName?.set(boolValue, forKey: "boolTest")
        suiteName?.set(intValue, forKey: "intTest")
        suiteName?.set(doubleValue, forKey: "doubleTest")
        suiteName?.set(floatValue, forKey: "floatTest")
        suiteName?.set(urlValue, forKey: "urlTest")
    }

    @IBAction func creatUserDefaultStandard(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add new UserDefaults Standard", message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            UserDefaults.standard.set(string, forKey: "string")
            UserDefaults.standard.set(stringValue, forKey: "stringTest")
            UserDefaults.standard.set(boolValue, forKey: "boolTest")
            UserDefaults.standard.set(intValue, forKey: "intTest")
            UserDefaults.standard.set(doubleValue, forKey: "doubleTest")
            UserDefaults.standard.set(floatValue, forKey: "floatTest")
            UserDefaults.standard.set(urlValue, forKey: "urlTest")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func creatUserDefaultSuite(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add new SuiteName for UserDefaults", message: nil, preferredStyle: .alert)
        alert.addTextField { text in
            text.placeholder = "SuiteName"
        }
        alert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            var text = alert.textFields?[0].text ?? ""
            
            let suiteName = UserDefaults(suiteName: text)
            suiteName?.set(string, forKey: "string")
            suiteName?.set(stringValue, forKey: "stringTest")
            suiteName?.set(boolValue, forKey: "boolTest")
            suiteName?.set(intValue, forKey: "intTest")
            suiteName?.set(doubleValue, forKey: "doubleTest")
            suiteName?.set(floatValue, forKey: "floatTest")
            suiteName?.set(urlValue, forKey: "urlTest")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func creatKeychain(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Keychain service", message: nil, preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "service" }
        alert.addTextField { $0.placeholder = "value" }
        
        alert.addAction(.init(title: "OK", style: .default, handler: { _ in
            let service = alert.textFields?[0].text ?? ""
            let text = alert.textFields?[1].text ?? ""
            let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")
            if text.isEmpty == false {
                keychain[service] = text
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showLocalDataAction(_ sender: UIButton) {
        LocalData().show()
    }
}
