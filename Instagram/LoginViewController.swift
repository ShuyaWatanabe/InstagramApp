//
//  LoginViewController.swift
//  Instagram
//
//  Created by Shuya Watanabe on 2020/09/23.
//  Copyright © 2020 Shuya Watanabe. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    //　ログインボタンをタップした時に呼ばれるメソッド
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let passward = passwordTextField.text {
            // 入力されていない場合何もしない
            if address.isEmpty || passward.isEmpty {
                SVProgressHUD.showError(withStatus: "必須項目を入力してください")
                return
            }
            
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: passward) { authResult, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました")
                    return
                }
                print("DEBUG_PRINT: ログインに成功しました。")
                
                SVProgressHUD.dismiss()
                
                //　画面を閉じてタブ画面に戻る
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //　アカウント作成ボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
                   
                   //　いずれかでも入力されていない時は何もしない
                   if address.isEmpty || password.isEmpty || displayName.isEmpty {
                       print("DEBUG_PRINT:　何かが空文字です")
                       SVProgressHUD.showError(withStatus: "必須項目を入力してください")
                       return
                   }
            
                   SVProgressHUD.show()
                   
                   //　アドレスとパスワードでユーザー作成　成功すると自動的にログイン
                   Auth.auth().createUser(withEmail: address, password: password) { authResult, error in
                       if let error = error {
                           //エラーがあったら原因をprintしてreturnすることで以降の処理を実行せずに処理を終了
                           print("DEBUG_PRINT: " + error.localizedDescription)
                           SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました")
                           return
                       }
                       print("DEBUG_PRINT: ユーザー作成に成功しました。")
                       
                       //　表示名を設定する
                       let user = Auth.auth().currentUser
                       if let user = user {
                           let changeRequest = user.createProfileChangeRequest()
                           changeRequest.displayName = displayName
                           changeRequest.commitChanges{ error in
                               if let error = error {
                                   //　プロフィールの更新でエラーが発生
                                   print("DEBUG_PRINT: " + error.localizedDescription)
                                   SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました")
                                   return
                               }
                               print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                            
                               SVProgressHUD.dismiss()
                               
                               //　画面を閉じてタブ画面に戻る
                               self.dismiss(animated: true, completion: nil)
                           }
                       }
                   }
               }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
