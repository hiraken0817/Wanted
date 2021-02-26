//
//  UserProfileViewController.swift
//  Wanted
//
//  Created by 平尾健太 on 2021/02/21.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class UserProfileViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let homePostCellId = "homePostCellId"
    
    var userId:String?
    
    override func viewDidLoad() {
        self.navigationItem.title = "ユーザ名"
        
        fetchUser()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(UserProfileHeaderCell.self,forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier:headerId)
        
        collectionView.register(UserProfileProductCell.self, forCellWithReuseIdentifier:cellId )
        
        //        setupLogOutButton()
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfileProductCell
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "headerId",for: indexPath) as! UserProfileHeaderCell//強制ダウンキャスト
        header.user = self.user
        
        return header
    }
    
    //これでヘッダーのスペース確保
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
        
        
    }
    
    var user:User?
    
    private func fetchUser(){
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        
        Firestore.fetchUserWithUID(uid: uid){ (user) in
            
            self.user = user
            print(self.user)
            self.collectionView.reloadData()
            self.navigationItem.title = self.user?.username//タイトルにユーザー名を入れる
            //            self.pagenatePosts()
            
        }
    }
    
}
