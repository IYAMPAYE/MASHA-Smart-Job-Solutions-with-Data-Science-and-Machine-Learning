document.addEventListener('DOMContentLoaded', function() {
  const element = document.querySelector('.amazing-paragraph h1');
  if (!element) return;  // Safeguard if element is not found

  const words = ["Innovative", "Interactive", "Engaging"];
  let wordIndex = 0, charIndex = 0, isDeleting = false, speed = 200;

  function type() {
      const currentWord = words[wordIndex];
      const displayText = isDeleting ? currentWord.substring(0, charIndex--) : currentWord.substring(0, charIndex++);
      element.textContent = displayText;

      if (!isDeleting && charIndex === currentWord.length) {
          speed = 1000; isDeleting = true;
      } else if (isDeleting && charIndex === 0) {
          isDeleting = false;
          wordIndex = (wordIndex + 1) % words.length;
          speed = 200;
      }
      setTimeout(type, isDeleting ? 100 : speed);
  }
  type();
});

// Initialize GSAP Animations when scrolling
Shiny.addCustomMessageHandler('initGSAP', function(message) {
  gsap.to('.fade-in', {
    scrollTrigger: {
      trigger: '.analysis-box',
      start: 'top 80%',
      end: 'bottom 20%',
      scrub: true
    },
    opacity: 1,
    duration: 1
  });

  gsap.to('.path-icon', {
    scrollTrigger: {
      trigger: '.analysis-box',
      start: 'top center',
      end: 'bottom center',
      scrub: true
    },
    backgroundColor: '#00ff00',
    scale: 1.5,
    duration: 1
  });
});

$(document).ready(function() {
$('#filter_jobs').click(function() {
    $('#job_cards').fadeOut(200).fadeIn(500);  // Animation for job cards
});
});
