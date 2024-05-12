import SwiftUI

struct FeedView: View {
    let outfits: [Outfit]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(outfits) { outfit in
                        OutfitView(outfit: outfit)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Feed")
        }
    }
}
