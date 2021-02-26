//
//  CustomImageView.swift
//  Wanted
//
//  Created by 平尾健太 on 2021/02/26.
//

import UIKit

var imageCache = [String:UIImage]()//画像キャッシュ用配列

class CustomImageView: UIImageView {
    var lastURLUsedToLoadImage:String?
    
    func loadImage(urlString:String){
//        print("loading image...")
        
        lastURLUsedToLoadImage = urlString
        
        //読み込みを毎度行わないようにする
        if let cachedImage = imageCache[urlString]{//nilじゃなかったら走る処理
            self.image = cachedImage//キャッシュから取り出す
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){ (data,response,err)
            in
            
            if let err = err{
                print("画像の取得に失敗しました",err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {//nilの時走る処理
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {//非同期処理
                self.image = photoImage
            }
            
            
        }.resume()
    }
}

