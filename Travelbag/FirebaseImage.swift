//
//  FirebaseImage.swift
//  Travelbag
//
//  Created by ifce on 24/10/17.
//  Copyright © 2017 ifce. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct FirebaseImage {
    
    private var storageRef : StorageReference!
    var image: UIImage?
    
    init(image: UIImage) {
        self.image = image
        let storage = Storage.storage()
        storageRef = storage.reference()
    }
    
    func save(withResouceType type: String, withParentId id: String, withName name: String, errorHandler: @escaping (_ error: Error?)->Void){
        let fileRef = storageRef.child(type).child(id).child(name)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        let uploadTask = fileRef.putData((self.image?.compressedData())!, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                errorHandler(error)
                return
            }
        }
        
        uploadTask.observe(.success) { snapshot in
            print("Completed")
            
//            let downloadURL = metadata.downloadURL
            
            fileRef.downloadURL { url, error in
                if let error = error {
                    // Handle any errors
                } else {
                    let  databaseRef = Database.database().reference()
                    databaseRef.child(type).child(id).child("image").setValue(url?.absoluteString)
                    
                }
            }
            
            
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    print("File doesn't exist")
                    break
                case .unauthorized:
                    print("User doesn't have permission to access file")
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    print("User canceled the upload")
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    print("Unknown error occurred,")
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    print("Unknown error occurred,")
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
    }
}
}