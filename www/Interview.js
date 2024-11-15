
// AI_Interview Trainer 

document.addEventListener("DOMContentLoaded", function() {
    const video = document.getElementById("videoElement");
  
    // Initialize speech recognition
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    const recognition = new SpeechRecognition();
  
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia({ video: true })
        .then(stream => {
          video.srcObject = stream;
          video.play();
        })
        .catch(error => {
          console.error("Error accessing the camera: ", error);
          alert("Camera access is required to use this feature.");
        });
    } else {
      alert("Your browser does not support video streaming.");
    }
  
    // Function to start recording
    document.getElementById("record_button").addEventListener("click", function() {
      recognition.start();
      recognition.onstart = function() {
        console.log("Voice recognition started. Speak now.");
      };
  
      recognition.onresult = function(event) {
        const transcript = event.results[0][0].transcript; // Get the transcribed text
        console.log("Transcribed Text: ", transcript);
  
        // Send the transcript to the server
        Shiny.setInputValue("user_answer", transcript);
      };
  
      recognition.onerror = function(event) {
        console.error("Speech recognition error: ", event.error);
      };
  
      recognition.onend = function() {
        console.log("Voice recognition ended.");
      };
    });
  
    // Load facial recognition
    async function loadFacialRecognition() {
      try {
        const model = await blazeface.load();
        setInterval(async () => {
          try {
            const predictions = await model.estimateFaces(video, false);
            if (predictions.length > 0) {
              console.log("Face detected:", predictions[0]);
            }
          } catch (error) {
            console.error("Error during face estimation:", error);
          }
        }, 1000); // Adjust timing as needed
      } catch (error) {
        console.error("Error loading BlazeFace model:", error);
      }
    }
  
    loadFacialRecognition();
  });
  