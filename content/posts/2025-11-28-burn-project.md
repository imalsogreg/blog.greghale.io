---
title: A Deep-Learning Read-a-long
description: Blogging my experience with ML research
tags: AI
draft: true
---

While reading Thinking Fast and Slow[^thinking-fast-and-slow]() it's
hard _not_ to have research ideas about LLMs.

Here is one such idea I failed to not have: could we use priming to
embue an LLM with information that it will use when answering a
subsequent prompt? For example, if we want an LLM to produce a
code snippet that uses some new library, could we prime the LLM
with that library's documentation?

There are two quick responses to this idea that I'll address.
  1. "That's just fine-tuning!" 
  2. "That's just in-context learning!"
  
Let me explain a little more. This proposal isn't just fine-tuning,
because I'm not proposing to learn new weights based on specific
documentation. And it's not just in-context learning, because
the approach doesn't put the documentation into the context. I'll
be trying to learn a general ability for a model to be primed
with data prior to prompting, leaving the context free for
just the prompt itself.

The vague idea I have in mind is to add a layer on top of each
MLP in an existing transformer model, and call these the
"bias" layer. The bias layer will receive input from the
prior transformer layer, and it will feed forward to the following
layer's MLP.

During inference, the model is run in two steps - step one exposes 
it to the documentation, and this step results in activation
levels of the bias layer. These activations override the learned
bias _parameter_ of each unit in the bias layer. This is the priming
step. Then the query undergoes inference as usual, but with the
updated bias parameters in the bias layer exerting influence over
each output.

During training, there are the same steps, priming and generation.
In each step of training, we produce synthetic documentation and
a synthetic user prompt, with the goal being that the documentation
primes a correct output. The interesting twist is that we are
trying to learn the projection weighs into and out of the bias
layer that will result in the correct activation levels for the
generation phase. We'll freeze the weights of all the preexisting
transformer components. We're merely trying to learn how to prime.

I haven't tried to implement an LLM before, and I've only done
the most trivial fine-tuning of existing models. So in this
series of blog posts, I'll try to expose the entire raw process,
from ideation, to initial implementation, to giving up and going
back to other projects.
