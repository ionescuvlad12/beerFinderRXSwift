import UIKit

final class BeerTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var tagline: UILabel!
    
    func bind(_ viewModel:BeerItemViewModel) {
        self.titleLabel.text = viewModel.title
        self.detailsLabel.text = viewModel.subtitle
        self.abv.text = viewModel.abv
        self.tagline.text = viewModel.tagline
        // TO DO , cache the image
        self.img.imageFromServerURL(urlString: viewModel.imageUrl)
    }
}
