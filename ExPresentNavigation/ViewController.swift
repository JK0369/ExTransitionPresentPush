//
//  ViewController.swift
//  ExPresentNavigation
//
//  Created by 김종권 on 2023/08/06.
//

import UIKit

class ViewController: UIViewController {
    let vc1: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    let vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        return vc
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("present", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let button2: UIButton = {
        let button = UIButton()
        button.setTitle("push", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            button2.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 12),
        ])
        
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tap2), for: .touchUpInside)
    }
    
    @objc
    private func tap() {
        present(vc1, animated: true)
        
        // A화면에서 B화면을 present > A화면에서 present (x)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            print("<1> present!!!")
            self.present(self.vc2, animated: true)
        })
        
        // A화면에서 B화면을 present > B화면에서 present (o)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            print("<2> present!!!")
            self.vc1.present(self.vc2, animated: true)
        })
    }
    
    @objc
    private func tap2() {
        navigationController?.pushViewController(vc1, animated: true)
        
        if Bool.random() {
            // A화면에서 push > A화면에서 present (o)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                print("<1> present!!!")
                self.present(self.vc2, animated: true)
            })
        } else {
            // A화면에서 push > B화면에서 present (o)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                print("<2> present!!!")
                self.vc1.present(self.vc2, animated: true)
            })
        }
    }
}
