# AutoRerenderingView

SwiftUI Hack to Force a View to Re-render

Just pass a view that won't re-render when it's data changes along with a hash of the data it's using and the view will force refresh.

My theory for why this works is that it's forcing SwiftUI to destroy the underlying UIKit view for a least one frame and then the timer tells SwiftUI it needs it again causing SwiftUI have no other choice but to rebuild the underlying UIKit view from scatch. Ridiculous, but I like this hack to avoid rewriting my bad SwiftUI code when I have better things to do.

```swift

struct Example: View {

  let someData: String
  
  var body: some View {
    AutoRerenderingView(SomeAnnoyingViewStructThatDoesntRerender(data: someData), hash: someData.hash)
  }
}

```
