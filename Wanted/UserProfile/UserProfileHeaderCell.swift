//
//  UserProfileHeaderCell.swift
//  Wanted
//
//  Created by 平尾健太 on 2021/02/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UserProfileHeaderCell: UICollectionViewCell {
    
    var user:User?{
        didSet{//最後に処理
            
            guard let profileImageUrl = user?.profileImageUrl else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            
            usernameLabel.text = user?.username
//            setupEditFollowButton()
            
        }
    }
    
    let profileImageView:CustomImageView = {
        let iv = CustomImageView()
//        iv.backgroundColor = .red
        
        return iv
    }()
    
   
    
    let usernameLabel:UILabel = {
        let label = UILabel()
        label.text = "読み込み中..."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let requestLabel:UILabel = {
        let label = UILabel()
        
        let attributeText = NSMutableAttributedString(string: "11\n", attributes:[ NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize:16)])
        attributeText.append(NSAttributedString(string: "逆出品数",
                                                attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray,
                                                             NSAttributedString.Key.font:UIFont.systemFont(ofSize:14)]))
        label.attributedText = attributeText
        label.numberOfLines = 0//初期値は１
        label.textAlignment = .center
        
        let rightDividerView = UIView()
        rightDividerView.backgroundColor = UIColor.lightGray
        label.addSubview(rightDividerView)
        rightDividerView.anchor(top: label.topAnchor,
                               left: nil,
                               bottom: label.bottomAnchor,
                               right: label.rightAnchor,
                               paddingTop: 15,
                               paddingLeft: 0,
                               paddingBottom: -15,
                               paddingRight: 0,
                               width: 0.5,
                               height: 0)
        
        return label
    }()
    
    let followerLabel:UILabel = {
        let label = UILabel()
        
        let attributeText = NSMutableAttributedString(string: "11\n", attributes:[ NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize:16)])
        attributeText.append(NSAttributedString(string: "フォロワー",
                                                attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray,
                                                             NSAttributedString.Key.font:UIFont.systemFont(ofSize:14)]))
        label.attributedText = attributeText
        label.numberOfLines = 0//初期値は１
        label.textAlignment = .center
        
        
        let rightDividerView = UIView()
        rightDividerView.backgroundColor = UIColor.lightGray
        label.addSubview(rightDividerView)
        rightDividerView.anchor(top: label.topAnchor,
                               left: nil,
                               bottom: label.bottomAnchor,
                               right: label.rightAnchor,
                               paddingTop: 15,
                               paddingLeft: 0,
                               paddingBottom: -15,
                               paddingRight: 0,
                               width: 0.5,
                               height: 0)
        
        return label
    }()
    
    let followingLabel:UILabel = {
        let label = UILabel()
        
        let attributeText = NSMutableAttributedString(string: "11\n", attributes:[ NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize:16)])
        attributeText.append(NSAttributedString(string: "フォロー中",
                                                attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray,
                                                             NSAttributedString.Key.font:UIFont.systemFont(ofSize:14)]))
        label.attributedText = attributeText
        label.numberOfLines = 0//初期値は１
        label.textAlignment = .center
        return label
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("フォローする", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(handleEditProfileOrFollow), for: .touchUpInside)
        return button
    }()
    
    @objc func handleEditProfileOrFollow() {
       print("Follow")
    }
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,
                                left: nil,
                                bottom: nil,
                                right: nil,
                                paddingTop: 30,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 100,
                                height: 100)
        
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        profileImageView.layer.cornerRadius = 100/2
        profileImageView.clipsToBounds = true
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor,
                                left: nil,
                                bottom: nil,
                                right: nil,
                                paddingTop: 15,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 0,
                                height: 0)
        
        usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        setupUserStatsView()
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: usernameLabel.bottomAnchor,
                                       left: leftAnchor,
                                       bottom: nil,
                                       right: rightAnchor,
                                       paddingTop: 75,
                                       paddingLeft: 40,
                                       paddingBottom: 0,
                                       paddingRight: 40,
                                       width: 0,
                                       height: 40)
        
        setupEvaluation()
        
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [requestLabel, followerLabel, followingLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: usernameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 45, paddingBottom: 0, paddingRight: 45, width: 0, height: 50)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    fileprivate func setupEvaluation(){
        let star = UIImageView()
        star.image = UIImage(systemName: "star.fill")
        star.tintColor = .systemYellow
        
        let star2 = UIImageView()
        star2.image = UIImage(systemName: "star.fill")
        star2.tintColor = .systemYellow
        
        let star3 = UIImageView()
        star3.image = UIImage(systemName: "star.fill")
        star3.tintColor = .systemYellow
        
        let star4 = UIImageView()
        star4.image = UIImage(systemName: "star.leadinghalf.fill")
        star4.tintColor = .systemYellow
        
        let star5 = UIImageView()
        star5.image = UIImage(systemName: "star")
        star5.tintColor = .systemYellow
        
        let stackView = UIStackView(arrangedSubviews: [star, star2, star3 ,star4 ,star5])
        
        stackView.distribution =  .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        let evNum = UIButton()
        evNum.setTitle("212", for: .normal)
        evNum.setTitleColor(.systemBlue, for: .normal)
        evNum.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
     
        
        addSubview(evNum)
        evNum.anchor(top: editProfileFollowButton.bottomAnchor,
                     left: nil,
                     bottom: nil,
                     right: rightAnchor,
                     paddingTop: 14,
                     paddingLeft: 0,
                     paddingBottom: 0,
                     paddingRight: 100,
                     width: 0,
                     height: 0)
    
        
        addSubview(stackView)
        stackView.anchor(top: editProfileFollowButton.bottomAnchor,
                         left: leftAnchor,
                         bottom: nil,
                         right: evNum.leftAnchor,
                         paddingTop: 12,
                         paddingLeft: 100,
                         paddingBottom: 0,
                         paddingRight: 12,
                         width: 0,
                         height: 30)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
