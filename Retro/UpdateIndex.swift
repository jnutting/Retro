import Foundation

func updateIndexForComputer(computer: Computer) -> NSUserActivity {
    let activity = NSUserActivity(activityType: "com.thoughtbot.retro.computer.show")
    activity.userInfo = ["name": computer.shortDescription]
    activity.title = computer.shortDescription
    activity.keywords = [computer.model, computer.company, computer.cpu]
    activity.eligibleForHandoff = false
    activity.eligibleForSearch = true
    
    activity.becomeCurrent()
    return activity
}