import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var ramLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var resolutionLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var detailItem: Computer? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        if let detail = self.detailItem {
            if yearLabel != nil {
                navigationItem.title = detail.shortDescription
                yearLabel.text = detail.productionStartYear
                cpuLabel.text = detail.cpuDescription
                ramLabel.text = detail.ram
                colorLabel.text = detail.color
                resolutionLabel.text = detail.maxScreenResolution
                imageView.image = detail.image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
}
