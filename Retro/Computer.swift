import UIKit

struct Computer {
    let company: String
    let model: String
    let productionStartYear: String
    let cpu: String
    let cpuSpeed: String
    let ram: String
    let color: String
    let maxScreenResolution: String
    let image: UIImage
    
    var shortDescription: String {
        return "\(company) \(model)"
    }
    
    var cpuDescription: String {
        return "\(cpuSpeed) \(cpu)"
    }
}