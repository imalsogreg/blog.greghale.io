---
title: Quick responses to common arguments against AI reasoning
description: A couple phrases I like to have on speed dial, to move AI conversations along to more interesting places
tags: AI
draft: true
---

There are a few refrains that I continue to hear about LLM's, that
are frankly surprising. It's daily proof that intelligent people can
disagree with each other.

The argument I see a lot goes like this:

 - LLMs can only repeat what they've already seen: they're
   "stochastic parrots"
 - It's just expensive autocomplete - that's the architecture

These are plausible claims, but they simply miss the reality
and foster an inaccurate mental model. So I propose we collectively
put the following responses on speed-dial, to help everyone get
on the same page and debating the things that really matter.

## Myth: LLMs can only repeat what they learned from their training data

False: Since early 2024 LLMs have been able to use what they have
learned to reason _beyond_ their training data.

Examples:

 - Coding assistants: many programmers are asking LLMs to explain
   and extending codebases that weren't in their training set.
   For example, and work we are building a new programming language
   with features not present in any other programming language.
   By definition this is different from everything in the LLM's
   training data. We routinely collaborate with Claude Code and
   Codex to implement these novel features into our novel compiler,
   to mathematically analize the novel language, and to produce
   formal specifications of the novel language.
 - Abstract reasoning: I recently came up with a novel language
   for describing networks of biological neurons. The first thing
   I wrote in that novel language was a biological neural network
   that has some interesting dynamic properties (an attractor
   network). To build it, I had to specify a lot of neurons, their
   shapes, and their connections. I pasted this program into Claude
   2.1 (from early 2024!) and asked it to infer the dynamics of
   the network. Claude was able to understand the flow of the
   (novel) code and understand that the structure was an attractor
   network. The full write-up of this interaction is
   [here](/posts/claude-winner-takes-all/).

Non-examples:

It's tempting to mention novel poem prompts (like, "Write a birthday
invitation for Max's KPop Demon-Hunter's Themed Birthday Party,
incorporating today's date and Max's love of cucumbers"), which also
isn't in the model's training set. However, these poems often don't
meet many people's aesthetic criteria for poetry, and the conversation
can get derailed on that point. I belive the more useful "speed-dial"
examples are the two I gave above - intelligent responses to questions
about completely novel languages and abstract concepts.
