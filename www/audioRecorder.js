let recorder, audioBlob, audioChunks = [];

// Function to start recording
function startRecording() {
  if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    alert("Your browser does not support audio recording.");
    return;
  }

  navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
    recorder = new MediaRecorder(stream);

    // Clear previous data
    audioChunks = [];
    recorder.start();
    console.log("Recording started...");

    // Show the recording indicator
    toggleRecordingIndicator(true);

    // Store audio data as it's available
    recorder.ondataavailable = e => audioChunks.push(e.data);

    // When recording stops, process the audio
    recorder.onstop = () => {
      audioBlob = new Blob(audioChunks, { type: 'audio/webm' });
      const audioURL = URL.createObjectURL(audioBlob);
      document.getElementById('audioPlayback').src = audioURL;
      console.log("Recording completed.");

      // Hide the recording indicator
      toggleRecordingIndicator(false);
    };

  }).catch(err => {
    console.error("Error accessing microphone:", err);
    alert("Microphone access is required to record audio. Please enable it in your browser settings.");
  });
}

// Function to stop recording
function stopRecording() {
  if (recorder && recorder.state === "recording") {
    recorder.stop();
    console.log("Recording stopped.");
  } else {
    console.log("Recorder not started or already stopped.");
  }
}

// Function to play the recorded audio
function playRecording() {
  const audioPlayback = document.getElementById('audioPlayback');
  if (audioPlayback.src) {
    audioPlayback.play();
    console.log("Playing recording...");
  } else {
    console.log("No audio to play.");
  }
}

// Function to submit the recorded audio to Shiny
function submitAudio() {
  if (!audioBlob) {
    alert("No audio recorded. Please record audio first.");
    return;
  }

  // Convert audio to base64 and send to Shiny
  const reader = new FileReader();
  reader.onloadend = () => {
    const base64AudioMessage = reader.result.split(',')[1];
    Shiny.setInputValue('audio_base64', base64AudioMessage);
    console.log("Audio submitted to Shiny as Base64.");
    
    // Show submission feedback
    displaySubmissionFeedback("Audio submitted successfully!", "success");
  };
  reader.readAsDataURL(audioBlob);
}

// Function to toggle the recording indicator on/off
function toggleRecordingIndicator(isRecording) {
  const indicator = document.getElementById('recordingIndicator');
  if (isRecording) {
    indicator.style.display = 'block';
    indicator.textContent = "Recording in progress...";
  } else {
    indicator.style.display = 'none';
  }
}

// Function to display submission feedback
function displaySubmissionFeedback(message, type) {
  const feedbackContainer = document.getElementById('submissionFeedback');
  feedbackContainer.style.display = 'block';
  feedbackContainer.textContent = message;
  feedbackContainer.className = `feedback ${type}`;
  
  // Hide feedback after a few seconds
  setTimeout(() => { feedbackContainer.style.display = 'none'; }, 3000);
}

// Setup UI elements and event listeners when the page is fully loaded
document.addEventListener("DOMContentLoaded", () => {
  const startBtn = document.getElementById('startRecording');
  const stopBtn = document.getElementById('stopRecording');
  const playBtn = document.getElementById('playRecording');
  const submitBtn = document.getElementById('submitRecording');
  
  // Add a recording indicator to the DOM
  const recordingIndicator = document.createElement('div');
  recordingIndicator.id = 'recordingIndicator';
  recordingIndicator.style.display = 'none';
  recordingIndicator.style.color = 'red';
  document.body.appendChild(recordingIndicator);
  
  // Add a submission feedback container to the DOM
  const feedbackContainer = document.createElement('div');
  feedbackContainer.id = 'submissionFeedback';
  feedbackContainer.style.display = 'none';
  feedbackContainer.style.marginTop = '10px';
  feedbackContainer.style.padding = '10px';
  feedbackContainer.style.borderRadius = '5px';
  feedbackContainer.style.color = 'white';
  feedbackContainer.style.fontWeight = 'bold';
  document.body.appendChild(feedbackContainer);

  // Event listeners for buttons
  startBtn.addEventListener('click', () => {
    startRecording();
    toggleRecordingIndicator(true);
  });

  stopBtn.addEventListener('click', () => {
    stopRecording();
    toggleRecordingIndicator(false);
  });

  playBtn.addEventListener('click', playRecording);
  submitBtn.addEventListener('click', submitAudio);
});

// Register custom message handlers with Shiny for additional control
Shiny.addCustomMessageHandler("startRecording", () => {
  startRecording();
  toggleRecordingIndicator(true);
});

Shiny.addCustomMessageHandler("stopRecording", () => {
  stopRecording();
  toggleRecordingIndicator(false);
});

Shiny.addCustomMessageHandler("playRecording", playRecording);
Shiny.addCustomMessageHandler("submitAudio", submitAudio);
