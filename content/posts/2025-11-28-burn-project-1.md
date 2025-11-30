---
title: A Deep-Learning Read-a-long
description: Blogging my experience with ML research
tags: AI
draft: true
---

I've decided to try out the [burn](https://github.com/tracel-ai/burn)
project. I've played a little with PyTorch and I'm curious enough about
`burn` to feel it's worth trying it out. I'm a little worried that the
right solution is HuggingFace's `transformers`, because that would give
me easy access to all the MLP layers of existing small language models.
So, we'll just see.

Some questions I encountered while getting started:
 - Am I supposed to use `Tensor` or `TensorData`? I thought I saw somewhere
   that `Tensor` is deprecated, but it's still used in the book's Getting Started
   section?
 - Using tinyllama and llama32-3b in `burn-lm` I get about one token per second,
   when building in release mode, on my M3 MacOS machine. Oh, I see I need the
   `--features metal` flag. Now I get 200 TPS!
