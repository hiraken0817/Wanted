//
//  FireStoreUtils.swift
//  Wanted
//
//  Created by 平尾健太 on 2021/02/26.
//

import Foundation
import FirebaseFirestore

extension Firestore {
// MARK:ユーザ情報の取得
    static func fetchUserWithUID(uid:String,completion: @escaping (User) -> ()){

        Firestore.firestore().collection("users").document(uid).getDocument{ (snapshot, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗しました。",err)
                return
            }
            guard let userDictionary = snapshot?.data() else { return }
            let user = User(uid: uid,dictionary: userDictionary)

            completion(user)
        }
    }
}
