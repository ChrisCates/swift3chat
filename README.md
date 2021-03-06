# swift3chat
Finally, Swift 3 has a Chat UI that works out of the box.

Chris Cates :star:
hello@chriscates.ca

## Introduction

s3c acts as a UIViewController that prebuilds a chat view for you.
It works directly with a public struct called `s3c_struct`.

## Preview

![preview](preview.png)

## Installation

In podfile
```
pod "s3c"
```

Then run
```
pod install
```

## Setup

```
import s3c

class myViewController: s3c {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Optional
        let item = [
            "from": "Chris Cates",
            "message": "Woohoo! Easy Chat UIs",
            "image": UIImage(named: "placeholder")
        ]
        s3c_struct.messages.insert(item, at: 0)

        //Required
        initializeChat()
    }

}
```

## Implementation with real chat

Say you have an array of messages you want to propagate into the chat. You can simply delegate via the `addMessage()` function

```
  override func viewDidLoad() {
    //What was in original...
  }

  func populateChat() {
    let text: String = "My message"
    let from: String = "Chris Cates"
    let photo: UIImage = UIImage(named: "whatever_asset")

    //Can just delegate messages via add message function
    addMessage(text: text, from: from, photo: photo)
  }
```

## s3c_struct spec

All of these variables are editable but keep in mind non declared variables will be reinitialized on initializeChat() function declaration as specified in above example

```
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
```

Published under MIT License :)
