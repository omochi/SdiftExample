import UIKit

public class ContributorView : UIView {
    public var id: Int!
    
    @IBOutlet public var nameLabel: UILabel!
    @IBOutlet public var contributionLabel: UILabel!
    
    public static func loadFromXIB() -> ContributorView {
        let objs = Bundle.main.loadNibNamed("ContributorView", owner: nil, options: nil)!
        return objs.compactMap { $0 as? ContributorView }.first!
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 288, height: 66)
    }
}
