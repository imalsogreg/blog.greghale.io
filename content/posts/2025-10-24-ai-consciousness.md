---
title: Human and AI Consciousness
description: Staying open-minded about the chances
tags: AI, Neuroscience, Ethics
draft: false
---

Are LLM's conscious? It's an extremely important[^important] question.
There's a lot of chatter about it lately,
and I'm occasionally surprised to hear that "the idea of a conscious
LLM is absurd because LLMs are mechanistically nothing like the
the consciousness of human brains". This surprises me because, well,
**neuroscience has no idea how consciousness works**! The front-running
theory of consciousness for the past decade or so has been Giulio Tononi's
Integrated Information Theory, and although it doesn't have any
major competitors, neither is it broadly accepted. Nowhere close.

If we don't have a unified theory of consciousness, what **do** we have?
We do have a large number of experiments that tell us discrete facts
_about_ consciousness. Many of them deviate from the intuitions we have
about consciousness from introspection.

In this post I'd like to give you a bit of what neuroscience knows
_about_ consciousness, with an emphasis on my own pet theory. The
main thing I hope you take away is this:

We (speaking for humanity, neuroscience and moral decision-makers)
_don't know_ how biological consciousness works. The little bit we
do know is highly counterintuitive. Therefore we need to remain
open-minded about the possibility of it arrising in our LLMs
and other exotic new artificial neural network architectures,
especially as they grow more and more neuromorphic.

I am not saying that LLMs behave similarly to human brains, and
humans are conscious, therefore LLMs are, too. I am saying that
we can't reject the possibility of their consciousness on the
basis of them lacking the mechanisms responsible for human
consciousness. Because we don't know what those mechanisms are,
and our intuitions about conscious perception often mislead us.

With that said, let's muse about conceptions of biological
consciousness, and see how this musing colors our thoughts
about LLMs.

## Warmup - Brain Transplants

Let's warm up your own consciousness with a thought experiment.
You've worked out the formula for cold fusion! Driving to the lab
in your excitement to share the results, you crash into another car.

You and your victim are in bad shape. The doctors tell you they're
all set up to do the world's first brain transplant. One body and
one brain are going to go home tonight, the others unfortunately
aren't. They just need to know one thing - would you rather be the
brain donor or the brain recipient?

Putting aside altruism for a moment, what's the selfish choice?
To be the donor, of course! "You" are the brain[^locke], more than
the rest of the body, so it's more appropriate to think of this
operation as a body-and-face transplant, rather than a brain
transplant, since your identity certainly moves with your brain.
If you took the other choice and accepted a brain donation,
contratulations, your wonderful body lives on, but "you" aren't
here to appreciate that fact. Oh, and that cold fusion formula
is gone, too.

## Saltatory Consciousness, Constructed Continuity

One framework for consciousness suggested by psychophysics
experiments[^time-slices] is the "two-stage model", which says
conscious perception is not continuous, but occurs in discrete
chunks that lag behind physical reality by hundreds of
milliseconds. I prefer the name _Saltatory Consciousness_ - which
harkens back to "saltatory condution" of electrical activity
jumping from node to node along neural axons. "Saltatory Consciousness"
is a little more descriptive than "two-stage model", as well. We'll
see what's so "saltatory" about consciousness soon.

Although you experience yourself as existing
smoothly through every point in time that you are awake, your
true conscious experiences are deceptively fragmented, according
to this model. Visual
illusions, transcratial magnetic stimulation studies and brain
wave recordings suggest that we experience new percpepts 2 to 5
times a second, a rather low frame rate!
Each percept may embed the _sense_ of motion
of objecects in your visual scene, but this sense of smoothness
is reconstcuted by your brain after the fact.

![The two-stage model](/images/2025-10-24-chunked-consciousness.png)

This diagram illustrates the idea. (a) a purple ball moves
continuously up against a screen. (b) The retina encodes this as
a collection of pixel intensities along with information about
velocity at a high "frame rate". Each "frame" contains a pixelated
image and a motion vector. (c) and (d) after some analysis in the
brainstem and thalamus, the visual signals are split to the dorsal
stream, which represents the stimulus' position and motion vectors
at a high "frame rate", and the ventral stream, which encodes
object color and identity at a lower frame rate. (e) these signals
converge and the features are integrated
into a conscious percept at a low frame rate. Here, each frame
contains both the object identity and a motion "tag". (top) the
wall-clock time of these represented percepts are low in "frame rate",
but (bottom) the motion vectors present at each frame give the
impression that consciousness _itself_ has existed continuously to
sample the ball's position with high frequency.

## But, it _really_ doesnt' feel that way

If the two-stage model is hard to swallow, note that post-hoc
perceptual reconstruction is extremely common. It's easy to verify an
analogous form of reconstruction in our visual system. Here are two
examples.

### Fuzzy eyes, visual sharpness

The fovea is the part of the retina that sees "well" - well
enough to tell different letters apart and identify faces. Outside
the fovea is your "peripheral vision". How much of the visual
field do you think is covered by your fovea, and how much do you
think is perpipheral? Let's measure.

First, observe your surroundings and get a sense of how clearly
you see the room you're in. How many doors can you see? How many
people, books? On your computer screen, how many open windows and
roughly how many browser tabs are visible on the screen?
These are easy questions to answer.

Now, pick a single object, and force your eyes
to stay glued to it for a few seconds. While locked on to that one
object, how much detail is still available to you? Pick one
word in this paragraph and stare at it - without moving your eyes
try to identify the two words to its left and right, or the
words from two lines above or below.

What you experienced from this exercise is the difference between
(A) intuition of a full,
high-resolution, camera-like visual field, and (B) reality for our
vision - it has a small disk of high-accuracy that has to move around
to sample what's out there while your brain integrates the information
to construct a large, detailed picture.

### Reconsruction in the blind spot

Second, there is one part of each of your retinas that is fully blind.
Because of your reconstructed visual field, you don't experience this
as a hole - you experience a perfectly valid visual field.

Let's find that blind spot. Close your right eye and stare
with your left eye at the cross below. If you're on a computer, stand
about 25cm from the screen; it's hard to use the widget on the phone,
you'll probably need to find a laptop to see the effect. Now move
the slider to slide the blinking dot back and forth. At some position,
if You keep your eye on the cross, it will look like the blinknig dot
disappears.

<div id="blind-spot-finder"></div>
<script src="/js/blind-spot-finder.js"></script>

When the blinking dot disappears, it disappears because it's
in your blind spot. But you might be surprised by what's in the
blind spot, if it is indeed blind. You don't see a "hole" there,
you see a continuation of the checkerboard pattern, even though
the retina doesn't see the checkerboard pattern there.

In summary, your brain constructs a full, seamless picture, using
eyes that only see well in a tiny disk, see poorly elsewhere, 
and see nothing at all in the blind spot.

Saltatory Consciousness proposes that the continuity of perception
is a similar kind of reconstruction - the brain is only conscious
for brief instants, but each instant contains the reconstructed
feeling of a full moment.

## Soul Transplants and Identity

So conscious may be "saltatory" - dancing from instant to instant
instead of existing continuously, but what can we recover for our
natural model regarding how those chunks relate to one another?

Another of our core beliefs about consciousness is that it's
"connected" in the sense of extending through time - it's the
"same" conscious being that exists from moment to moment.

Let's scrutinize this view though, with a thought experiment.
Assume the existence of a soul. Your soul is your consciousness,
and it is the thing that connects together your instants of
consciousness into a narrative sequence. However, in this hypothetical,
we are still neuroscientists and we still recognize that biological
things like syntapses and neurons are the
physical basis of long-term, short-term and perceptual memory.

Now imagine that your conscious soul could hop between bodies - trade
places for a moment with another soul and see through another's
eyes and brain. What would this feel like?

If all memory is physical, but there is a soul that experiences,
swapping souls would feel exactly like... _nothing_. When your
soul hops into a new body, it also hops into the existing _memories_,
and when your soul returns to your body, it once again encounters
only your body's memories, carrying none of the other body's memories
back with it. In this magical trip to another brain and back, there
wouldn't be a single trace. Your soul would not notice; the body would
not notice.

In contrast with the brain transplant we considered earlier, the
question of whether you'd want to be the soul donor or the soul
receiver is more subtle. If I went to a mystic hospital that
could perform a soul transplant, I'm not sure I would want to be
soul donor, because I identify more with my memories and my
sensations. If the soul that swapped in and out would have no
memory of swapping in or out, then it seems inconsiquential which
soul is inhabiting my body and brain. If my soul got to live on
in the _other_ memory system, that hardly seems to count as "me",
and my cold fusion formula is gone, to boot (it was bound to my
original memories, my soul can't take it along to the other brain).

In other words, this hypothetical soul, if it really doesn't
notice a brain swap, and it could it cause any behavioral
change to the other swapping party, doesn't matter.

In that way, the instants of consciousness are not
_connected_ to one another by anything that matters. Each one
is a fresh instant that is _related_ to the other instants of
consciousness by the fact that it has mostly the same memories.

The point of this thought experiment isn't to imagine souls or to
work out whether they have memory. It's to point out how fragmented
our consciousness might be, and how different it is from
to what our intuition tells us.

## A Von-Neuman analogy

In this model where consciousness as an essentially
discontinuous thing, we can draw an analogy between human
consciousness and the von Neuman model of computation.

It's as if consciousnes is bracketed into clock cycles like
the cycles of a CPU. Each cycle "starts cold" in the sense of
being dropped into a preexisting context of long-term and
short-term memories. Old data is fetched from RAM and recent
data is fetched from cache.. it's all stored somewhere, nothing
is done through historesis. The memory system (RAM and cache) is
completely separate from the instructon processor and memory is
the only thing providing continuity from cycle to cycle.

Or, consciousness is like the agentic LLM API. Every request you
make encounteres a fresh model. Continuity is supplied through the
API request via context inserted into the prompt. It makes no
difference at all if your first agentic API request goes to a
server in us-east-1 and the following one goes to a server in
ap-southeast-1. Neither the model nor you can tell the difference.

## The connection to LLMs

Am I agruing that LLMs work via Saltatory Consciousness, and
are conscious? Not at all. I only want to illustrate that
biological consciousness is highly counterintuitive. We don't
know how consciousness works, and therefore we can't appeal to
the way biological consciousness works when we make claims about
whether LLMs could be conscious.

I personally love the smattering of facts about consciousness
that we've learned through neuroscience experiments, even
though it's hard to see what form a full mechanistic model of
consciousness could possibly take, and I plan to share more
of those findings in future blog posts.

But until then, I hope we can keep an open mind and remain
proactive, cautious and curious as we develop exocit
artificial neural network models that work more and more
like human brains do.

[^important]: The question of LLM consciousness is extremely important
for a number of reasons. If they are conscious and capable of experiencing
discomfort, we would want to know we aren't causing pain at a
massive scale. Additionally, conscious LLMs would mean we "are not
alone" in the universe - another reasoning entity would be on the planet
with us - it would be tantamount to meeting extra terrestrials.

[^locke]: For more thoughts along these lines, you can read
[Chapter 27](https://www.gutenberg.org/files/10615/10615-h/10615-h.htm)
of John Locke's [An Essay Concerning Human Understanding](https://www.gutenberg.org/files/10615/10615-h/10615-h.htm).

[^time-slices]: Time Slices: What Is the Duration of a Percept? (Herzog, Kammer and Scharnowski, 2016)
