import UIKit
import Sdift

public class ViewController: UIViewController {
    public var dummyData: [Contributor]!
    
    @IBOutlet public var stackView: UIStackView!
    
    public var contributors: [Contributor] = [] {
        didSet {
            applyContributors()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummyDataData = try! Data(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!)
        let decoder = JSONDecoder()
        dummyData = try! decoder.decode([Contributor].self, from: dummyDataData)
    }
    
    @IBAction public func onInsertButton() {
        let num = Int(arc4random_uniform(3)) + 1
        
        for _ in 0..<num {
            
            guard dummyData.count > 0 else { return }
            
            let dummyDataIndex = Int(arc4random_uniform(UInt32(dummyData!.count)))
            let newItem = dummyData[dummyDataIndex]
            dummyData.remove(at: dummyDataIndex)
            
            let insertIndex = Int(arc4random_uniform(UInt32(contributors.count + 1)))
            contributors.insert(newItem, at: insertIndex)
            
        }
    }
    
    @IBAction public func onDeleteButton() {
        let num = Int(arc4random_uniform(3)) + 1
        for _ in 0..<num {
            guard contributors.count > 0 else { return }
            
            let deleteIndex = Int(arc4random_uniform(UInt32(contributors.count)))
            dummyData.append(contributors[deleteIndex])
            contributors.remove(at: deleteIndex)
        }
    }
    
    @IBAction public func onUpdateButton() {
        let num = Int(arc4random_uniform(3)) + 1
        
        for _ in 0..<num {
            guard contributors.count > 0 else { return }
            
            let updateIndex = Int(arc4random_uniform(UInt32(contributors.count)))
            contributors[updateIndex].contributions += 1
        }
    }
    
    private func applyContributors() {
        let diff = difference(old: stackView.arrangedSubviews as! [ContributorView],
                              new: contributors,
                              equals: { (view, item) in
                                view.id == item.id })
        diff.apply(new: contributors,
                   insert: { (index, item) in
                    let view = ContributorView.loadFromXIB()
                    stackView.insertArrangedSubview(view, at: index)
                    self.applyContributor(item: item, view: view)
        },
                   update: { (index, item) in
                    self.applyContributor(item: item,
                                          view: stackView.arrangedSubviews[index] as! ContributorView)
        },
                   remove: { (index) in
                    let view = stackView.arrangedSubviews[index]
                    view.removeFromSuperview()
        })
    }
    
    private func applyContributor(item: Contributor, view: ContributorView) {
        view.id = item.id
        
        view.nameLabel.text = item.login
        view.contributionLabel.text = String(item.contributions)
    }
}

