//
//  JoinContinuingViewController.swift
//  Travelbag
//
//  Created by IFCE on 16/10/17.
//  Copyright © 2017 ifce. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class JoinContinuingViewController: UIViewController {
	
	var ref: DatabaseReference!
	var user = Auth.auth().currentUser

	@IBOutlet weak var inputFirstName: UITextField!
	@IBOutlet weak var inputLastName: UITextField!
	@IBOutlet weak var inputSex: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		inputLastName.layer.borderWidth = 1.0
		inputLastName.layer.borderColor = UIColor.white.cgColor
		
		inputFirstName.layer.borderWidth = 1.0
		inputFirstName.layer.borderColor = UIColor.white.cgColor
		
		inputSex.layer.borderWidth = 1.0
		inputSex.layer.borderColor = UIColor.white.cgColor
		
		
		ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func didTapRefresh(_ sender: Any) {
		self.ref.child("user_profile").child("\(user!.uid)/(first_name)").setValue(inputFirstName.text)
		self.ref.child("user_profile").child("\(user!.uid)/(last_name)").setValue(inputLastName.text)
		self.ref.child("user_profile").child("\(user!.uid)/(sex)").setValue(inputSex.text)
		
		
		
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
