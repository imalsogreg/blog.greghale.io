+++
title = "About Me"
template = "page.html"
date = 2024-01-01
+++

<div class="timeline">

<div class="timeline-item">
<div class="timeline-marker"></div>
<div class="timeline-date">2006 - 2014</div>
<div class="timeline-content">
<h3>MIT - PhD in Neuroscience</h3>
<p style="margin-top: 0.75rem;">
<a href="https://dspace.mit.edu/handle/1721.1/100872">Thesis</a> · <a href="https://www.youtube.com/watch?v=dfHL5wvqTPw">Defense Video</a>
</p>

<div class="timeline-projects">

<div class="project-card">
<img
    src="/images/about/sequences.png"
    alt="Neural Sequences"
    data-caption="<strong>Position decoding in simultaneously recorded 
    hippocampal place cell populations.</strong> (A) Reconstructed positions using neurons from
    medial (red) and lateral (green) hippocampal cells, which are phase-offset
    by 25ms. (B) Theta-aligned average spatial reconstructions. (C) Cross
    correlation of medial and lateral hippocampal representations, showing
    that the fine-timescale trajectories are aligned in time, albeit with
    earlier sampling in medial and later sampling in lateral neurons.">
<div class="project-info">
<h4>Timing codes for space</h4>
<p>
    Theta oscillations in the hippocampus organize the fine-timescale
    activity of space-encoding neurons into spatial trajectories. Theta
    is a traveling wave, and I studied the effect of phase delays
    within the hippocampus on spatial encoding.
</p>
</div>
</div>

<div class="project-card">
<img
    src="/images/about/headToHeadDecoding.png"
    alt="Head-to-Head Decoding"
    data-caption="<strong>Batch vs. realtime hippocampal decoding.</strong>
    Left: behavioral timescale position decoding closely matches the subject's
    location in both batch and real-time analysis. Center: fine-timescale
    theta sequences are clearer in batch recordings, but clearly resolvable
    in real-time. Right: When the subject pauses to consume rewards,
    hippocampal &quot;replay&quot; events are discernible in both batch
    and real-time decoding.">
<div class="project-info">
<h4>Realtime position decoding</h4>
<p>
    I developed signal processing algorithms and Bayesian
    decoding methods to read fine-timescale spatial trajectories
    during spatial learning.
</p>
</div>
</div>

</div>
</div>
</div>

<div class="timeline-item">
<div class="timeline-marker"></div>
<div class="timeline-date">2013 - 2019</div>
<div class="timeline-content">
<h3>Center for Brains, Minds and Machines</h3>

<div class="timeline-projects">

<div class="project-card">
<img
    src="/images/about/cbmm.png"
    alt="CBMM">
<div class="project-info">
<h4>Software engineering for cognitive science research</h4>
<p>
    To ease the transition into software, I developed web apps for
    Cog Sci and AI researchers at MIT to conduct experiments.
</p>
</div>
</div>

</div>
</div>
</div>

<div class="timeline-item">
<div class="timeline-marker"></div>
<div class="timeline-date">2010 - Present</div>
<div class="timeline-content">
<h3>Functional Programming</h3>

<div class="timeline-projects">

<div class="project-card">
<pre>
<code>x
&lambda;x.f
f x</code>
</pre>
<div class="project-info">
    <h4>Lambda calculus</h4>
    <p>
    A Steve Yegge <a href="https://sites.google.com/site/steveyegge2/ocaml">blog post</a>
    introduced me to the world of functional programming (FP). I fell
    in love and retooled for a career in software engineering.
    </p>
</div>
</div>

<div class="project-card">
    <img
        src="/images/about/haskell.jpg"
        alt="Haskell Logo"
    />
<div class="project-info">
    <h4>Haskell Open Source</h4>
    <ul>
        <li>Organized Boston Haskell User Group & Hackathons</li>
        <li>Comaintained the Snap web framework</li>
        <li>Got excited about compilers</li>
    </ul>
</div>
</div>

</div>
</div>
</div>

<div class="timeline-item">
<div class="timeline-marker"></div>
<div class="timeline-date">2023 - Present</div>
<div class="timeline-content">
<h3>BoundaryML</h3>
<p>
Working on <a href="https://boundaryml.com">BAML</a>, a language for building typesafe LLM applications. Combining my passion for language design with the cutting edge of AI.
</p>
</div>
</div>

<div class="timeline-item">
<div class="timeline-marker"></div>
<div class="timeline-date">Ongoing</div>
<div class="timeline-content">
<h3>Side Projects</h3>
<p>
Building <a href="https://neuronbench.com">NeuronBench</a> - a browser-based neuron simulator that brings together my love of neuroscience, functional programming, and the web.
</p>

<div class="timeline-projects">
<div class="project-card">
<video autoplay loop muted playsinline class="project-video"
    data-caption="<strong>NeuronBench web-based neuron simulation.</strong> NeuronBench.com allows teachers and students to build neurons with custom
    morphology, membrane dynamics, and synaptic connectivity, and run them
    in the browser.">
    <source src="/images/frosted.mp4" type="video/mp4">
</video>
<div class="project-info">
<h4>NeuronBench</h4>
<p>
    A WebGL-powered neuron simulator for exploring neural dynamics in real-time.
</p>
</div>
</div>
</div>

</div>
</div>

</div>

<div id="lightbox" class="lightbox-overlay">
    <span class="lightbox-close" onclick="closeLightbox()">&times;</span>
    <div class="lightbox-content" onclick="event.stopPropagation()">
        <img id="lightbox-img" src="" alt="">
        <video id="lightbox-video" autoplay loop muted playsinline style="display:none;">
            <source id="lightbox-video-src" src="" type="video/mp4">
        </video>
        <div id="lightbox-caption" class="lightbox-caption"></div>
    </div>
</div>

<script>
function openLightbox(src, caption, isVideo) {
    const img = document.getElementById('lightbox-img');
    const video = document.getElementById('lightbox-video');
    const videoSrc = document.getElementById('lightbox-video-src');

    if (isVideo) {
        img.style.display = 'none';
        video.style.display = 'block';
        videoSrc.src = src;
        video.load();
        video.play();
    } else {
        video.style.display = 'none';
        img.style.display = 'block';
        img.src = src;
    }

    document.getElementById('lightbox-caption').innerHTML = caption || '';
    document.getElementById('lightbox').classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeLightbox() {
    document.getElementById('lightbox').classList.remove('active');
    document.body.style.overflow = '';
    document.getElementById('lightbox-video').pause();
}

document.getElementById('lightbox').addEventListener('click', function(e) {
    if (e.target === this) closeLightbox();
});

document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeLightbox();
});

document.querySelectorAll('.project-card img').forEach(img => {
    img.addEventListener('click', function() {
        openLightbox(this.src, this.dataset.caption, false);
    });
});

document.querySelectorAll('.project-card video').forEach(video => {
    video.addEventListener('click', function() {
        const source = this.querySelector('source');
        openLightbox(source.src, this.dataset.caption, true);
    });
});
</script>
