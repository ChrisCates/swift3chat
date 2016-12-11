//
//  ViewController.swift
//  swift3chat
//
//  Created by Chris Cates on 2016-12-08.
//  Copyright © 2016 Chris Cates. All rights reserved.
//

import UIKit

public struct s3c_struct {
    static var offset: Int = 0
    static var fontSize: Int = 14
    static var photoSize: Int = 33
    static var user1_name: String! = "Anonymous"
    static var user1_photo: UIImage! = UIImage(named: "placeholder")
    static var user2_name: String! = "Anonymous"
    static var user2_photo: UIImage! = UIImage(named: "placeholder")
    static var messagesContainer: UITableView!
    static var messagesContainerDict: NSMutableDictionary!
    static var messages: Array<Dictionary<String, Any>> = Array()
    static var button: UIButton!
    static var buttonDict: NSMutableDictionary!
    static var input: UITextField!
    static var inputDict: NSMutableDictionary!
}

class s3c: UIViewController, UITableViewDataSource, UITableViewDelegate {

    public func initializeChat() {
        
        if (s3c_struct.messagesContainerDict == nil) {
            s3c_struct.messagesContainerDict = NSMutableDictionary()
            s3c_struct.messagesContainerDict["CGRect"] = CGRect(
                x: 15,
                y: 15,
                width: view.frame.width - 30,
                height: view.frame.height - 80
            )
            s3c_struct.messagesContainerDict["CGSize"] = CGSize(
                width: view.frame.width - 30,
                height: view.frame.height - 80
            )
            s3c_struct.messagesContainerDict["CGPoint"] = CGPoint(
                x: 0,
                y: view.frame.height - 80
            )
        }
        
        if (s3c_struct.messagesContainer == nil) {
            s3c_struct.messagesContainer = UITableView(frame: s3c_struct.messagesContainerDict["CGRect"] as! CGRect)
            s3c_struct.messagesContainer.contentSize = s3c_struct.messagesContainerDict["CGSize"] as! CGSize
        }
        
        if (s3c_struct.inputDict == nil) {
            s3c_struct.inputDict = NSMutableDictionary()
            s3c_struct.inputDict["CGRect"] = CGRect(
                x: 15,
                y: view.frame.height - 50,
                width: view.frame.width - 145,
                height: 40
            )
            s3c_struct.inputDict["placeholder"] = "Type a message"
            s3c_struct.inputDict["borderWidth"] = CGFloat(2.5)
            s3c_struct.inputDict["borderColor"] = UIColor.black.cgColor
        }
        
        if (s3c_struct.input == nil) {
            s3c_struct.input = UITextField(frame: s3c_struct.inputDict["CGRect"] as! CGRect)
            s3c_struct.input.placeholder = (s3c_struct.inputDict["placeholder"] as! String)
            s3c_struct.input.borderBottom(
                borderWidth: s3c_struct.inputDict["borderWidth"] as! CGFloat,
                borderColor: s3c_struct.inputDict["borderColor"] as! CGColor
            )
        }
        
        if (s3c_struct.buttonDict == nil) {
            s3c_struct.buttonDict = NSMutableDictionary()
            s3c_struct.buttonDict["CGRect"] = CGRect(
                x: view.frame.width - 115,
                y: view.frame.height - 50,
                width: 100,
                height: 40
            )
            s3c_struct.buttonDict["bg"] = UIColor.black
            s3c_struct.buttonDict["color"] = UIColor.white
            s3c_struct.buttonDict["title"] = "Send"
        }
        
        if (s3c_struct.button == nil) {
            s3c_struct.button = UIButton(frame: s3c_struct.buttonDict["CGRect"] as! CGRect)
            s3c_struct.button.backgroundColor = (s3c_struct.buttonDict["bg"] as! UIColor)
            s3c_struct.button.tintColor = s3c_struct.buttonDict["color"] as! UIColor
            s3c_struct.button.setTitle((s3c_struct.buttonDict?["title"] as! String), for: .normal)
        }
        
        s3c_struct.user1_photo = s3c_struct.user1_photo.resizeImage(targetSize: CGSize(width: s3c_struct.photoSize, height: s3c_struct.photoSize))
        s3c_struct.user2_photo = s3c_struct.user2_photo.resizeImage(targetSize: CGSize(width: s3c_struct.photoSize, height: s3c_struct.photoSize))
        
        s3c_struct.button.addTarget(self, action: #selector(self.sendMessage), for: .touchUpInside)
        
        s3c_struct.messagesContainer.delegate = self
        s3c_struct.messagesContainer.dataSource = self
        s3c_struct.messagesContainer.separatorStyle = UITableViewCellSeparatorStyle.none
        s3c_struct.messagesContainer.allowsSelection = false
        s3c_struct.messagesContainer.estimatedRowHeight = 100
        s3c_struct.messagesContainer.transform = CGAffineTransform.init(rotationAngle: CGFloat(-M_PI))
        s3c_struct.messagesContainer.rowHeight = UITableViewAutomaticDimension
        
        print("Adding swift 3 chat views")
        view.addSubview(s3c_struct.input)
        view.addSubview(s3c_struct.button)
        view.addSubview(s3c_struct.messagesContainer)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(s3c_struct.messages.count)
        return s3c_struct.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "chatCell")
        
        let message = s3c_struct.messages[indexPath.row]
        cell.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = (message["from"] as! String) + " said:\n" + (message["message"] as! String)
        cell.imageView?.image = message["image"] as? UIImage
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    @objc func sendMessage() {
        
        let text: String = (s3c_struct.input.text)!
        let from: String = s3c_struct.user1_name
        
        s3c_struct.input.text = ""
        
        addMessage(text: text, from: from, photo: s3c_struct.user1_photo)
        
    }
    
    public func addMessage(text: String, from: String, photo: UIImage) {
        
        let item: Dictionary = [
            "from": from,
            "message": text,
            "image": photo
        ] as [String : Any]
        
        print("Message is: " + text)
        
        s3c_struct.messages.insert(item, at: 0)
        s3c_struct.messagesContainer.reloadData()

    }
    
}

extension UITextField {
    
    func borderBottom(borderWidth: CGFloat!, borderColor: CGColor) {
        
        let border = CALayer()
        
        border.borderColor = borderColor
        border.frame = CGRect(
            x: 0,
            y: self.frame.size.height - borderWidth,
            width: self.frame.size.width,
            height: self.frame.size.height
        )
        border.borderWidth = borderWidth
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
}

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
}

