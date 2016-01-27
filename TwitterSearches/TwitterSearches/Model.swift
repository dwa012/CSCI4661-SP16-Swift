// Model.swift
// Manages the Twitter Searches data
import Foundation

// delegate protocol that enables Model to
// notify controller when the data changes
protocol ModelDelegate {
    func modelDataChanged()
}

// manages the saved searches
class Model {
    // keys used for storing app's data in app's NSUserDefaults
    private let pairsKey = "TwitterSearchesKVPairs" // for tag-query pairs
    private let tagsKey = "TwitterSearchesKeyOrder" // for tags
    
    private var searches: [String: String] = [:] // stores tag-query pairs
    private var tags: [String] = [] // stores tags in user-specified order
    
    private let delegate: ModelDelegate // delegate is MainViewController
    
    // initializes the Model
    init(delegate: ModelDelegate) {
        self.delegate = delegate
        
        // get the NSUserDefaults object for the app
        let userDefaults = NSUserDefaults.standardUserDefaults()

        // get Dictionary of the app's tag-query pairs
        if let pairs = userDefaults.dictionaryForKey(pairsKey) {
            self.searches = pairs as! [String : String]
        }
        
        // get Array with the app's tag order
        if let tags = userDefaults.arrayForKey(tagsKey) {
            self.tags = tags as! [String]
        }
        
        // register to iCloud change notifications
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "updateSearches:",
            name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification,
            object: NSUbiquitousKeyValueStore.defaultStore())
    }
    
    // called by view controller to synchronize model after it's created
    func synchronize() {
        NSUbiquitousKeyValueStore.defaultStore().synchronize()
    }
    
    // returns the tag at the specified index
    func tagAtIndex(index: Int) -> String {
        return tags[index]
    }
    
    // returns the query String for a given tag
    func queryForTag(tag: String) -> String? {
        return searches[tag]
    }
    
    // returns the query String for the tag at a given index
    func queryForTagAtIndex(index: Int) -> String? {
        return searches[tags[index]]
    }
    
    // returns the number of tags
    var count: Int {
        return tags.count
    }
    
    // deletes the tag from tags Array, and the corresponding
    // tag-query pair from searches iCloud
    func deleteSearchAtIndex(index: Int) {
let tempSearches = searches // hack to fix iOS 8.1.x bug
        searches.removeValueForKey(tags[index])
        let removedTag = tags.removeAtIndex(index)
        updateUserDefaults(updateTags: true, updateSearches: true)
        
        // remove search from iCloud
        let keyValueStore = NSUbiquitousKeyValueStore.defaultStore()
        keyValueStore.removeObjectForKey(removedTag)
    }
    
    // reorders tags Array when user moves tag in controller's UITableView
    func moveTagAtIndex(oldIndex: Int, toDestinationIndex newIndex: Int) {
        let temp = tags.removeAtIndex(oldIndex)
        tags.insert(temp, atIndex: newIndex)
        updateUserDefaults(updateTags: true, updateSearches: false)
    }
    
    // update user defaults with current searches and tags collections
    func updateUserDefaults(updateTags  updateTags: Bool, updateSearches: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if updateTags {
            userDefaults.setObject(tags, forKey: tagsKey)
        }
        
        if updateSearches {
            userDefaults.setObject(searches, forKey: pairsKey)
        }
       
        userDefaults.synchronize() // force immediate save to device
    }
    
    // update or delete searches when iCloud changes occur
    @objc func updateSearches(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            // check reason for change and update accordingly
            if let reason = userInfo[
                NSUbiquitousKeyValueStoreChangeReasonKey] as! NSNumber? {
                    
                // if changes occurred on another device
                if reason.integerValue ==
                        NSUbiquitousKeyValueStoreServerChange ||
                   reason.integerValue ==
                        NSUbiquitousKeyValueStoreInitialSyncChange {
                        
                    performUpdates(userInfo) // update searches
                }
            }
        }
    }
    
    // add, update or delete searches based on iCloud changes
    func performUpdates(userInfo: [NSObject : AnyObject?]) {
        // get changed keys NSArray; convert to [String]
        let changedKeysObject =
            userInfo[NSUbiquitousKeyValueStoreChangedKeysKey]
        let changedKeys = changedKeysObject as! [String]
        
        // get NSUbiquitousKeyValueStore for updating
        let keyValueStore = NSUbiquitousKeyValueStore.defaultStore()
        
        // update searches based on iCloud changes
        for key in changedKeys {
            if let query = keyValueStore.stringForKey(key) {
                saveQuery(query, forTag: key, syncToCloud: false)
            } else {
let tempSearches = searches // hack to fix iOS 8.1.x bug
                searches.removeValueForKey(key)
                tags = tags.filter{$0 != key}
                updateUserDefaults(updateTags: true, updateSearches: true)
            }

            delegate.modelDataChanged() // update the view
        }
    }
    
    // save a tag-query pair
    func saveQuery(query: String, forTag tag: String,
        syncToCloud sync: Bool) {

        // Dictionary method updateValue returns nil if key is new
let tempSearches = searches // hack to fix iOS 8.1.x bug
        let oldValue = searches.updateValue(query, forKey: tag)
            
        if oldValue == nil {
            tags.insert(tag, atIndex: 0) // store search tag
            updateUserDefaults(updateTags: true, updateSearches: true)
        } else {
            updateUserDefaults(updateTags: false, updateSearches: true)
        }
        
        // if sync is true, add tag-query pair to iCloud
        if sync {
            NSUbiquitousKeyValueStore.defaultStore().setObject(
                query, forKey: tag)
        }
    }
}


/*************************************************************************
* (C) Copyright 2015 by Deitel & Associates, Inc. All Rights Reserved.   *
*                                                                        *
* DISCLAIMER: The authors and publisher of this book have used their     *
* best efforts in preparing the book. These efforts include the          *
* development, research, and testing of the theories and programs        *
* to determine their effectiveness. The authors and publisher make       *
* no warranty of any kind, expressed or implied, with regard to these    *
* programs or to the documentation contained in these books. The authors *
* and publisher shall not be liable in any event for incidental or       *
* consequential damages in connection with, or arising out of, the       *
* furnishing, performance, or use of these programs.                     *
*                                                                        *
* As a user of the book, Deitel & Associates, Inc. grants you the        *
* nonexclusive right to copy, distribute, display the code, and create   *
* derivative apps based on the code. You must attribute the code to      *
* Deitel & Associates, Inc. and reference the book's web page at         *
* www.deitel.com/books/ios8fp1/. If you have any questions, please email *
* at deitel@deitel.com.                                                  *
*************************************************************************/

