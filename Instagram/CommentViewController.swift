//
//  CommentViewController.swift
//  Instagram
//
//  Created by Shuya Watanabe on 2020/09/26.
//  Copyright © 2020 Shuya Watanabe. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    let name = Auth.auth().currentUser?.displayName
    
    var postRef = Firestore.firestore().collection(Const.PostPath).document()
    
    
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func postCommentButton(_ sender: Any) {
        
        let postData = [
            "comments": FieldValue.arrayUnion(["\(name!) : \(self.commentTextField.text!)"])
        ]
        
        postRef.updateData(postData)
        
       
    //　画面遷移は○、テーブルビューが反映されてない
        
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
        
        
        
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
