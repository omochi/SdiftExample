# SdiftExample

This is example app of Sdift.

https://github.com/omochi/Sdift

# Build

```
$ carthage update --no-build
```

# View update by diff

```swift
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
```
