//
//  Extensions.swift
//  Spotify
//
//  Created by Alex on 4/30/21.
//

import UIKit

extension UIViewController {
    
    func showErrorMessage(_ message: String, title: String = "Error", action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            action?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String? = nil, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            action?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(title: String,
                      message: String,
                      confirmTitle: String,
                      cancelTitle: String,
                      confirmHandler: (() -> Void)? = nil,
                      cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: { _ in
            confirmHandler?()
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in
            cancelHandler?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

extension UITableView {
    
    func registerCell(_ cell: UITableViewCell.Type) {
        self.register(cell, forCellReuseIdentifier: String(describing: cell))
        print("Cell Type: \(cell), Cell Id: \(String(describing: cell))")
//        self.register(cell(), forCellReuseIdentifier: "")
    }
    
}

extension UIView {
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
    
}


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}


extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else { return string }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}


extension Notification.Name {
    static let albumSavedNotification = Notification.Name("albumSavedNotification")
}
