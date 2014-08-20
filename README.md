This project is accompanied by this blog post:

[http://codingventures.com/articles/Custom-Views-In-XCode-6/](http://codingventures.com/articles/Custom-Views-In-XCode-6/)

In order to run this with some SoundCloud files, you need to get a client_key and secret from SoundCloud by registering your app. Once you get those than you can create a ```secret_key.plist``` file with the following:

      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>clientKey</key>
        <string>YOUR_KEY</string>
        <key>clientSecret</key>
        <string>YOUR_SECRET</string>
      </dict>
      </plist>

Or if you are just interested in seeing how the custom views work as described in the blog post, open up the ```FirstViewController.swift``` file and comment out the below code, so that SoundCloud APIs are not called:

      var client = SoundCloudClient.sharedInstance
      client.retrieveSoundInfo("https://soundcloud.com/silentletters/swimming-lessons") {
        (soundInfo, error) in
          if let soundData = soundInfo {
            client.retrieveArtworkUrl(soundData.waveformUrl!) {
              (waveformData, error) in
              if let data = waveformData {
                self.waveformView.totalTime = NSTimeInterval(soundData.duration!)
                self.waveformView.amplitudes = data
              }
            }
          }
      }

