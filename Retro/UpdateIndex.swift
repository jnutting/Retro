import Foundation
import CoreSpotlight
import MobileCoreServices
import UIKit

func updateIndexForComputer(computer: Computer) -> NSUserActivity {
    let activity = NSUserActivity(activityType: "com.thoughtbot.retro.computer.show")
    activity.userInfo = ["name": computer.shortDescription]
    activity.title = computer.shortDescription
    activity.keywords = [computer.model, computer.company, computer.cpu]
    activity.eligibleForHandoff = false
    activity.eligibleForSearch = true
    
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
    attributeSet.title = computer.shortDescription
    attributeSet.contentDescription = "\(computer.shortDescription)\n\(computer.cpuDescription)\n\(computer.productionStartYear)"
    attributeSet.thumbnailData = UIImagePNGRepresentation(computer.image)
    
    let item = CSSearchableItem(uniqueIdentifier: computer.shortDescription, domainIdentifier: "retro-computer", attributeSet: attributeSet)
    
    CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([item]) { error in
        if let error = error {
            NSLog("indexing error: \(error)")
        }
    }
    
    activity.contentAttributeSet = attributeSet
    activity.becomeCurrent()
    return activity
}