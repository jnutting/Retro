import UIKit

class ComputerDataSource: NSObject {
    let computers: [Computer]
    
    override init() {
        let bundle = NSBundle.mainBundle()
        let plistURL = bundle.URLForResource("Computers", withExtension: "plist")!
        let contents = NSDictionary(contentsOfURL: plistURL)!
        let computerSpecs = contents["items"] as! NSArray
        
        computers = computerSpecs.map { spec in
            let dict = spec as! Dictionary<String, String>
            let imagePath = bundle.pathForResource(dict["image"], ofType: nil)!
            let image = UIImage(contentsOfFile: imagePath)!
            let computer = Computer(company: dict["company"]!,
                model: dict["model"]!,
                productionStartYear: dict["productionStartYear"]!,
                cpu: dict["cpu"]!,
                cpuSpeed: dict["cpuSpeed"]!,
                ram: dict["ram"]!,
                color: dict["color"]!,
                maxScreenResolution: dict["maxScreenResolution"]!,
                image: image)
            return computer
        }
        super.init()
    }
}
