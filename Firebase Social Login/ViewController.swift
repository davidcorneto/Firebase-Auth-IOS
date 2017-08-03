//
//  ViewController.swift
//  Firebase Social Login
//
//  Created by Vesperia on 8/3/17.
//  Copyright © 2017 Vesperia. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //Frame's are obelete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        
        //Add custom fb button
        let customFBButon = UIButton(type: .system)
        customFBButon.backgroundColor = .blue
        customFBButon.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        customFBButon.setTitle("Custom FB Login", for: .normal)
        customFBButon.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButon.setTitleColor(.white, for: .normal)
        view.addSubview(customFBButon)
        
        //Custom FB Login
        customFBButon.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        
    }
    
    func handleCustomFBLogin(){
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil
            {
                print(err!)
                return
            }
            
            self.showEmailAddress()
        }
    }
    
    func showEmailAddress(){
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, email, name"]).start { (connection, result, err) in
            
            
            if err != nil
            {
                print("Failed to get start graph request", err!)
                return
            }
            
            print(result!)
        }
    }


    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout to facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil
        {
            print(error)
            return
        }
        
        print("SUCCESS FULL LOGIN WITH FACEBOOK")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createAlert(title: "Information", message: "Hari ini adalah hari kamis")
    }
    
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //Creating one button
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }


}

