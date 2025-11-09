+++
title = "Frosted Vertical Reflections in ffmpeg"
description = "How I create a frosted reflection effect for videos."
date = 2024-01-20

[taxonomies]
tags = ["VideoProcessing"]
+++

# Creating the "frosted reflection" effect for videos

I recently wanted to include a screenshot of NeuronBench into the landing page,
with the classic "frosted reflection" effect, where a hint of the image is
reflected just below the image. I normally do this is Gimp, but my NeuronBench
screenshot was actually a screen recording (video), and I wasn't about to repeat
this tedious process frame-by-frame.

The final result is here:

{{ video(src="/images/frosted.mp4", width="420", autoplay=true, loop=true, muted=true) }}

This blog post records the process, mostly as a record for me in case
I need to do it again in the future, or in case someone else finds the
style interesting and wants to replicate it.

# Dependencies

 - MacOS
 - QuickTime
 - ffmpeg
 - gimp

# Process

  1. Clean background: In the system settings, set the Wallpaper to solid white,
     matching the background color of the webpage where I'll embed this video.
     Then clear most of the desktop icons off of the desktop.
  1. Run the app: In my case: `cargo run --bin bevy --release`.
  1. Take the screen capture: In QuickTime, close the default file-chooser modal
     and select `File > New Screen Recording`. Frame the application window with
     generous space (avoid clipping the shadow dropped by the window). Click the
     "Stop" icon in the menu bar when done.
  1. Trim the time: `Edit > Trim` in QuickTime. Save.
  1. Crop the video:
     ```
     ffmpeg -i screengrab_trimmed.mov  -filter:v "crop=1332:1200:0:0" -c:a copy screengrab_cropped.mov
     ```
  1. Apply the gaussian blur, flip and composite:
     ```
     ffmpeg -i screengrab_cropped.mov -filter_complex "[0:v] split [original][mirror]; [mirror] vflip, gblur=sigma=10 [flipped]; [original][flipped] vstack" output.mov
     ```
     At this point, we have a stack of the original screen grab, with its mirror image blurred beneath.
     Next we need that blurred mirror image to fade to white.
  1. Determine the image dimensions:
     ```
     ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of default=noprint_wrappers=1 output.mov
     ```
     We will use this to create our gratient as a .png file with matching size in Gimp.
  1. Create a gradient that goes from transparent to solid white, starting at the top
     of the mirrored image and ending 20-40 pixels lower.
  1. Overlay the gradient onto the movie.
     ```
     ffmpeg -i output.mov -i gradient.png -filter_complex "overlay=0:main_h-overlay_h" output2.mov
     ```
  1. Trim excess vertical pixels from the video, now that much of the bottom mirror is masked off.

# Improvements

The space between the original window and its refelction looks muddy. This is because the original screen
grab included the dropped shadow from MacOS, which gets copied and flipped in the above process. The final
result would be much cleaner if the space between were clear of shadows. And it would be more semantically
consistent without the shadow, because the "floor" in our effect is below the screenshot (where our
reflection lands), not behind the screenshot (where the shadow is).

In the two versions of MacOS I'm running (Ventura and Sonoma), there is no configuration option to turn off
this shadow. And I can't simply use cropping at the first preprocessing step to crop out the shadow, because
the window is a rounded rectangle - some awkward shadow would remain in the corners.

So I could either (a) create a masking image in gimp - a rounded-rectangle frame - matching the size of
the screengrab window, and apply this during prepressing, or (b) perform my screen recording on a
linux machine.
