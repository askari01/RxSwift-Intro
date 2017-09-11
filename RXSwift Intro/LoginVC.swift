//
//  LoginVC.swift
//  RXSwift Intro
//
//  Created by Syed Askari on 9/11/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minimumPasswordLength = 5
let minimumUserNameLength = 5

class LoginVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLbl.text = "UserName must be \(minimumUserNameLength) in length"
        passwordLbl.text = "Password must be \(minimumPasswordLength) in length"
        // Do any additional setup after loading the view.
        
        let userNameValid = userNameTF.rx.text.orEmpty
            .map {$0.characters.count >= minimumUserNameLength}
            .shareReplay(1)
        
        let passwordValid = passwordTF.rx.text.orEmpty
            .map{$0.characters.count >= minimumPasswordLength}
            .shareReplay(1)
        
        let everythingValid = Observable.combineLatest(userNameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        userNameValid
            .bind(to: passwordTF.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userNameValid
            .bind(to: userNameLbl.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordLbl.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginBtn.rx.tap
            .subscribe (onNext: {[weak self] in self!.showAlert()})
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alertBox = UIAlertController(
            title: "Rx Form",
            message: "Data entered is correct congrats",
            preferredStyle: .alert
        )
        alertBox.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
    
        self.present(
            alertBox,
            animated: true,
            completion: nil
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
