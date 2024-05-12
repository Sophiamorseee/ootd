import SwiftUI

struct ContentView: View {
    @State private var outfits: [Outfit] = [
        Outfit(name: "Outfit 1", imageName: "placeholder_outfit", profileName: "Profile A"),
        Outfit(name: "Outfit 2", imageName: "placeholder_outfit", profileName: "Profile B"),
        Outfit(name: "Outfit 3", imageName: "placeholder_outfit", profileName: "Profile C")
    ]

    var body: some View {
        TabView {
            FeedView(outfits: outfits)
                .tabItem {
                    Label("Feed", systemImage: "person.2.circle")
                }

            AddOutfitView()
                .tabItem {
                    Label("", systemImage: "plus.circle.fill")
                }

            ProfileView(username: "Your Username", outfits: outfits)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
