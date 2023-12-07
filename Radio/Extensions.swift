//
//  Extensions.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import Foundation
import UIKit

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

extension UIViewController {
    func infiniteToastMessage(_ message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont(name: "WorkSans-Medium", size: 21)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(red: 0.221, green: 0.238, blue: 0.271, alpha: 1)

        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)

        messageLbl.frame = CGRect(x: 20, y: 150, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

        UIView.animate(withDuration: 1, animations: {
            messageLbl.alpha = 0
            }) { (_) in
            messageLbl.removeFromSuperview()
            }
        }
    }
}

struct GlobalVariables {
    static var allStations = [Station]()
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
