if (navigator.mediaDevices) {
  var mediaRecorder

  // listen to elm
  app.ports.recordStart.subscribe(function() {
    var constraints = { audio: true }
    navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {
      var chunks = []
      mediaRecorder = new MediaRecorder(stream)
      mediaRecorder.start()

      mediaRecorder.ondataavailable = function(e) {
        chunks.push(e.data)
      }

      mediaRecorder.onstop = function(e) {
        var blob = new Blob(chunks, { type: 'audio/ogg; codecs=opus' })
        var audioURL = window.URL.createObjectURL(blob)
        // send to elm
        app.ports.audioUrl.send(audioURL)
      }
    })
  })

  // listen to elm
  app.ports.recordStop.subscribe(function() {
    if (mediaRecorder) {
      mediaRecorder.stop()
    }
  })
}
