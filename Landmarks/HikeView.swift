/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view displaying information about a hike, including an elevation graph.
 */

import SwiftUI

extension AnyTransition{
    static var moveAndFade: AnyTransition{
        //AnyTransition.move(edge: .trailing)//Slides in and out from the same side
        let insertion = AnyTransition.move(edge: .trailing)//Slides in
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)//Shrinks
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = true
    
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
                    .animation(nil)
                
                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation{//Add (.easeInOut(duration: 4)) to slow down animation
                        self.showDetail.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        //.animation(nil)//Animations are done in order of lines (line counter on left of screen)
                        .scaleEffect(showDetail ? 1.5 : 1)//Gets bigger as it twists
                        .padding()
                        //.animation(.easeInOut)//Slows down animation so it visually appears to twist
                        //.animation(.spring())//Makes animation appear to twist
                }
            }
            
            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade)
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: hikeData[0])
                .padding()
            Spacer()
        }
    }
}
//"Pin" in preview keeps current preview open across all files
