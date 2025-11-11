// Blind Spot Finder Widget
// A simple interactive demonstration of the blind spot in human vision

(function () {
  function initBlindSpotFinder() {
    const container = document.getElementById("blind-spot-finder");
    if (!container) return;

    // Create the main canvas/rectangle
    const canvas = document.createElement("canvas");
    canvas.width = 800;
    canvas.height = 400;
    canvas.style.border = "1px solid #ccc";
    canvas.style.display = "block";
    canvas.style.margin = "20px auto";
    canvas.style.backgroundColor = "white";

    // Create slider container
    const sliderContainer = document.createElement("div");
    sliderContainer.style.textAlign = "center";
    sliderContainer.style.margin = "10px auto";
    sliderContainer.style.maxWidth = "800px";

    const sliderLabel = document.createElement("label");
    sliderLabel.textContent = "Move the dot: ";
    sliderLabel.style.marginRight = "10px";

    const slider = document.createElement("input");
    slider.type = "range";
    slider.min = "-90"; // Keep dot left edge at 10pt (dotBaseX=100 - radius=10)
    slider.max = "690"; // Keep dot right edge at 790pt (800 - radius=10)
    slider.value = "0";
    slider.step = "1";
    slider.style.width = "400px";

    sliderContainer.appendChild(sliderLabel);
    sliderContainer.appendChild(slider);

    // Create toggle button container
    const toggleContainer = document.createElement("div");
    toggleContainer.style.textAlign = "center";
    toggleContainer.style.margin = "10px auto";

    const toggleButton = document.createElement("button");
    toggleButton.textContent = "Toggle Checkerboard";
    toggleButton.style.padding = "8px 16px";
    toggleButton.style.cursor = "pointer";
    toggleButton.style.marginRight = "10px";

    const swapButton = document.createElement("button");
    swapButton.textContent = "Swap Sides";
    swapButton.style.padding = "8px 16px";
    swapButton.style.cursor = "pointer";

    toggleContainer.appendChild(toggleButton);
    toggleContainer.appendChild(swapButton);

    container.appendChild(canvas);
    container.appendChild(sliderContainer);
    container.appendChild(toggleContainer);

    // Get canvas context
    const ctx = canvas.getContext("2d");

    // Animation state
    let dotVisible = true;
    let dotOffset = 0;
    let checkerboardEnabled = true;
    let sidesSwapped = false;

    // Fixed positions
    const dotRadius = 10;

    // Function to get current positions based on swap state
    function getPositions() {
      if (sidesSwapped) {
        return {
          crossX: 100, // Cross on left
          crossY: 200,
          dotBaseX: 700, // Dot on right
          dotY: 200,
        };
      } else {
        return {
          crossX: 700, // Cross on right (100pt from right edge)
          crossY: 200,
          dotBaseX: 100, // Dot on left (100pt from left edge)
          dotY: 200,
        };
      }
    }

    // Draw the cross
    function drawCross(x, y) {
      ctx.strokeStyle = "black";
      ctx.lineWidth = 2;
      ctx.beginPath();
      // Vertical line
      ctx.moveTo(x, y - 10);
      ctx.lineTo(x, y + 10);
      // Horizontal line
      ctx.moveTo(x - 10, y);
      ctx.lineTo(x + 10, y);
      ctx.stroke();
    }

    // Draw checkerboard background
    function drawCheckerboard() {
      const squareSize = 20;
      const lightColor = "#f5f5f5";
      const darkColor = "#cbcbcb";

      for (let y = 0; y < canvas.height; y += squareSize) {
        for (let x = 0; x < canvas.width; x += squareSize) {
          const isEvenRow = Math.floor(y / squareSize) % 2 === 0;
          const isEvenCol = Math.floor(x / squareSize) % 2 === 0;
          ctx.fillStyle = isEvenRow === isEvenCol ? lightColor : darkColor;
          ctx.fillRect(x, y, squareSize, squareSize);
        }
      }
    }

    // Draw the dot
    function drawDot(x, y, visible) {
      if (visible) {
        ctx.fillStyle = "black";
        ctx.beginPath();
        ctx.arc(x, y, dotRadius, 0, Math.PI * 2);
        ctx.fill();
      }
    }

    // Animation loop
    function animate() {
      // Draw background (checkerboard or solid white)
      if (checkerboardEnabled) {
        drawCheckerboard();
      } else {
        ctx.fillStyle = "white";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
      }

      // Get current positions
      const positions = getPositions();

      // Draw cross (always visible)
      drawCross(positions.crossX, positions.crossY);

      // Draw dot with current offset and visibility
      const dotX = positions.dotBaseX + (sidesSwapped ? -dotOffset : dotOffset);
      drawDot(dotX, positions.dotY, dotVisible);

      requestAnimationFrame(animate);
    }

    // Toggle dot visibility at 1Hz with 50% duty cycle
    setInterval(() => {
      dotVisible = !dotVisible;
    }, 500); // 500ms = 0.5s, so full cycle is 1s (1Hz)

    // Update dot offset when slider changes
    slider.addEventListener("input", (e) => {
      dotOffset = parseInt(e.target.value);
    });

    // Toggle checkerboard when button is clicked
    toggleButton.addEventListener("click", () => {
      checkerboardEnabled = !checkerboardEnabled;
    });

    // Swap sides when button is clicked
    swapButton.addEventListener("click", () => {
      sidesSwapped = !sidesSwapped;
      // Reset slider to center when swapping
      slider.value = "0";
      dotOffset = 0;
    });

    // Start animation
    animate();
  }

  // Initialize when DOM is ready
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initBlindSpotFinder);
  } else {
    initBlindSpotFinder();
  }
})();
