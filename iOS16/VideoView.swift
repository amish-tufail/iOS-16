//
//  VideoView.swift
//  iOS16
//
//  Created by Meng To on 2022-10-07.
//

import SwiftUI
import AVKit

struct VideoView: View {
    let player = VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "video", withExtension: "mp4")!))
    
    var body: some View {
        player.ignoresSafeArea()
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
