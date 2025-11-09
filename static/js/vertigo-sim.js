// Vertigo simulator - converted from Haskell/Reflex to vanilla JavaScript

function createVertigoSimulator(containerId) {
    const container = document.getElementById(containerId);
    if (!container) return;

    // Create the UI structure
    const wrapper = document.createElement('div');
    wrapper.className = 'ypr-and-content';
    wrapper.style.cssText = 'display:flex; flex-direction: column-reverse; border-right: 10px solid lightgray';

    // Create content container
    const contentDiv = document.createElement('div');
    contentDiv.className = 'container';
    contentDiv.style.cssText = 'position:relative;';

    // Add the intro text
    const introP = document.createElement('p');
    introP.textContent = `To get into the right headspace, here is a vertigo simulator. You're already familiar with the feeling of a room spinning - this happens as your eyes repeatedly drift to one side, and jerk back to their starting position when they reach the end of their travel. The muscles that move your eyes up and down can do this too. And, as I was surprised to learn, there is a third direction in which the eye muscles can dance the Nystagmus: they can twist. Your eyes naturally twist as you tilt your head toward either shoulder, helping keep the top of your eyeballs pointed toward the ceiling. The ability to twist is limited of course - turning a cartwheel does not send your eyes for a full spin in your head, just as doing a somersault doesn't. To experience twist-vertigo, play with the "Roll" slider.`;

    const containedDiv = document.createElement('div');
    containedDiv.appendChild(introP);

    contentDiv.appendChild(containedDiv);

    // Create style element for keyframes
    const styleEl = document.createElement('style');
    contentDiv.appendChild(styleEl);

    // Create control table
    const controlTable = document.createElement('table');
    controlTable.className = 'xyz';

    const yawSlider = createSlider('yaw', controlTable);
    const pitchSlider = createSlider('pitch', controlTable);
    const rollSlider = createSlider('roll', controlTable);

    // Assemble the structure
    wrapper.appendChild(contentDiv);
    wrapper.appendChild(controlTable);
    container.appendChild(wrapper);

    // Add styles
    const globalStyle = document.createElement('style');
    globalStyle.textContent = `
        .range-input {
            z-index: 2;
        }

        .xyz {
            margin: 20px 0;
        }

        .xyz td {
            padding: 5px 10px;
        }

        .xyz input[type="range"] {
            height: 15px;
            border-radius: 5px;
            width: 200px;
        }
    `;
    document.head.appendChild(globalStyle);

    // Update animation based on slider values
    function updateAnimation() {
        const yaw = parseFloat(yawSlider.value);
        const pitch = parseFloat(pitchSlider.value);
        const roll = parseFloat(rollSlider.value);

        const animTime = (10 - Math.max(yaw, pitch, roll)) / 10;
        const top = pitch * 10;
        const left = yaw * 10;
        const rot = roll * 10;

        // Update keyframes
        styleEl.textContent = `
            @keyframes nystagmus {
                0%   { top: ${top}px; left: 0px; transform:rotate(0deg) translate(0px, ${top}px) }
                90%  { top: 0px; left: ${left}px; transform:rotate(${rot}deg) translate(${left}px, 0px)}
                100% { top: ${top}px; left: 0px; transform:rotate(0deg) translate(0px, ${top}px) }
            }
        `;

        // Update animation on contained div
        containedDiv.style.cssText = `
            animation-name: nystagmus;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-duration: ${animTime}s;
        `;
    }

    // Attach event listeners
    yawSlider.addEventListener('input', updateAnimation);
    pitchSlider.addEventListener('input', updateAnimation);
    rollSlider.addEventListener('input', updateAnimation);

    // Initial update
    updateAnimation();
}

function createSlider(label, table) {
    const row = document.createElement('tr');
    row.className = 'range-input';

    const labelTd = document.createElement('td');
    labelTd.textContent = label;

    const sliderTd = document.createElement('td');
    const slider = document.createElement('input');
    slider.type = 'range';
    slider.min = '0.01';
    slider.max = '10';
    slider.step = '0.01';
    slider.value = '0.01';

    sliderTd.appendChild(slider);
    row.appendChild(labelTd);
    row.appendChild(sliderTd);
    table.appendChild(row);

    return slider;
}

// Initialize on DOM ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
        createVertigoSimulator('vertigo-simulator');
    });
} else {
    createVertigoSimulator('vertigo-simulator');
}
