import Foundation
import SwiftUI

struct ProfileView: View {
    let username: String
    let outfits: [Outfit]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding()

                HStack(spacing: 40) {
                    VStack {
                        Text("Followers")
                            .font(.custom("Pacifico", size: 20)) // Custom font "Pacifico"
                        Text("100")
                    }

                    VStack {
                        Text("Following")
                            .font(.custom("Pacifico", size: 20)) // Custom font "Pacifico"
                        Text("50")
                    }
                }
                .padding(.horizontal, 20)

                Text("Your Looks")
                    .font(.custom("Pacifico", size: 24)) // Custom font "Pacifico"
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(outfits) { outfit in
                            Image(outfit.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()
            }
            .navigationBarTitle(username)
        }
    }
}
