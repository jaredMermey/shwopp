//
//  ChatViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 5/22/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation
class ChatViewController: JSQMessagesViewController  {
    
    //TEST
    var senderAvatar: UIImage!
    var recipientAvatar: UIImage!
    //END TEST
    
    //array of messages to show in collection view
    var messages: [JSQMessage] = []
    
    var keptProductSKU: String?
    
    var messageListener: MessageListener?
    
    //bubble design and colors
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        //collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        if let sku = keptProductSKU {
            fetchMessages(sku, {
                messages in
                
                for m in messages {
                    self.messages.append(JSQMessage(senderId: m.senderID, senderDisplayName: m.senderID, date: m.date, text: m.message))
                }
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if let sku = keptProductSKU {
            messageListener = MessageListener(keptProductSKU: sku, startDate: NSDate(), callback: {
                message in
                self.messages.append(JSQMessage(senderId: message.senderID, senderDisplayName: message.senderID, date: message.date, text: message.message))
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        messageListener?.stop()
    }
    
    override var senderDisplayName: String! {
        get {
            return currentUser()!.name
        }
        set {
            super.senderDisplayName = newValue
        }
    }
    
    override var senderId: String! {
        get {
            return currentUser()!.id
        }
        set {
            super.senderId = newValue
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        var data = self.messages[indexPath.row]
        
        if data.senderId == PFUser.currentUser()?.objectId {
            return outgoingBubble
        }
        else {
            return incomingBubble
        }
    }
    
    
    //TEST FOR AVATAR
    
    func updateAvatarImageForIndexPath( indexPath: NSIndexPath, avatarImage: UIImage) {
        let cell: JSQMessagesCollectionViewCell = self.collectionView.cellForItemAtIndexPath(indexPath) as! JSQMessagesCollectionViewCell
        cell.avatarImageView.image = JSQMessagesAvatarImageFactory.circularAvatarImage( avatarImage, withDiameter: 60 )
    }
    
    func updateAvatarForRecipient( indexPath: NSIndexPath, user: User ) {
        user.getPhoto({ (image) -> () in
            self.recipientAvatar = image
            self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
        })
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        var imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( UIImage(named: "profile-header"), withDiameter: 60 ) )
        if (self.messages[indexPath.row].senderId == self.senderId)
        {
            if (self.senderAvatar != nil)
            {
                imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( self.senderAvatar, withDiameter: 60 ) )
            }
            else
            {
                currentUser()!.getPhoto({ (image) -> () in
                    self.senderAvatar = image
                    self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
                })
            }
        }
        else
        {
            if (self.recipientAvatar != nil)
            {
                imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( self.recipientAvatar, withDiameter: 60 ) )
            }
            else
            {
                getUserAsync( self.messages[indexPath.row].senderId, { (user) -> () in
                    self.updateAvatarForRecipient( indexPath, user: user ) } )
            }
        }
        return imgAvatar
    }

    
    //END TEST
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        //self.messages.append(m)
        
        if let sku = keptProductSKU {
            saveMessage(sku, Message(message: text, senderID: senderId, date: date))
        }
        finishSendingMessage()
    }
}