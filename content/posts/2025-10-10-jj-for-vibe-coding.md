+++
title = "jj loves vibe coding"
description = "Why jj's interface is so great for vibe coding."
date = 2025-10-10

[taxonomies]
tags = ["AI"]
+++

AI coding assistants have sped up our coding. Parallel agents
are dividing the development times down further. Version control
is becoming more of a bottleneck. By [Amdahl's Law](https://en.wikipedia.org/wiki/Amdahl%27s_law) VCS is putting a new
fundamental limit on how fast software development can go. This isn't
just an intuitive claim, it's something that actively bugged me
at work and reminded me of an odd tool we used for _human_ based
VCS at Kadena: `jj`.

So, while implementing a meaty feature for the [BAML](https://github.com/boundaryml/baml) language with Claude Code, and
feeling the tedium of managing `git`'s staging area and branches,
I decided to dust off `jj` and try in this new AI coding context.
The results have been great. Here's why:

## 1. Automatic change tracking

Long ago, you accepted the fact that you just have to run `git add`
for every changed file. Not with `jj`!
`jj` tracks all changes for you, a massive time saver when most of
your keystrokes are prompting the AI, rather than directly writing
source code.

## 2. Low-friction commits

With `jj` you can create commits before the work, and changes get
written into that commit. It feels a bit like creating a directory,
then `cd`ing into that directory to create files there.

When you go back to `git` after this mindest change, you have the
opposite feeling: working with `git` feels creating a bunch of files,
then creating a folder, and moving files into the folder after the fact.

To highlight this difference in mindset: it's extremely common for me to
write a prompt asking for a new work
item, realize this work should be in its own commit, and quickly run
`jj new` to open a new commit before Claude Code has finished
its reasoning and begun to write code. Having a zero-friction way to
chunk up work is pure joy.

## 3. Easy commit shuffling (rebasing)

Rebasing is scary in `git` because it's easy to rewrite history and
damage the repository. Rebases in `jj` are safe and common.

This is how you move a single commit to some other place in the history:

```
jj rebase -r SOME_COMMIT --destination SOME_COMMIT
```

Or move a whole series of commits to some other place in the
history:

```
jj rebase --branch SOME_COMMIT --destination SOME_COMMIT
```

With parallel agents, rebasing is very common, and the improved
user experience in `jj` reduces rebase toil.

## 4. Easy Undo

Whatever you just did in `jj`, if you realize it didn't go the way
you expected, `undo` has you covered:

```
jj undo
```

Especially helpful while you're still learning the ropes. A lot of noise
is made about ChatGPT stealing traffic from StackOverflow. `jj`
will cut into this market share further by removing the need to search
for how to undo all the different `git` accidents that happen in
work projects.

If the AI goes down a bad path and writes a bunch of code you dislike,
`abandon` abandons the work item.

Abandon the current commit:

```
jj abandon
```

Abandon some other commit in the history:

```
jj abandon -r SOME_COMMIT
```

And if you forgot to introduce a new commit before starting the agent
on a coding task unrelated to one you had in-progress, it's easy
to split the work into two separate commits:

```
jj split TASK_2_FILE_1.hs TASK_2_FILE_2.hs
```

# jj loves vibe coding

Running `jj` feels like "managing" something:
high level, details-managed-for-you, simple. Running `git`
feels like "implementing" something. Low level, down in the
weeds, wrestling with the tools.

Vibe coding is managing a coding assistant, so `jj` is a great fit.

The purpose of this blog post is to summarize why I like
`jj` for vibe coding, not to provide a balanced comparison
between `jj` and `git`. That's why I've said nothing good about `git`
here and nothing bad about `jj`. When considering whether to adopt `jj`
at work or for your personal projects, of course you'll need
to try it yourself and read some tutorials.

Here are a few things to know if you're hearing about `jj` for the
first time and considering a switch:

  - `jj` is compatible with `git` and uses the `.git` directory for
    tracking repository state. So you can freely use `jj` even if
    the rest of the team uses `git`.
  - `jj` has a learning curve! It's easier to learn than `git`, but
    not trivial. It took me a few weeks to reach the same
    level of productivity that I built up over many years using
    `git`.
  - There is an excellent [tutorial from Steve Klabnik](https://steveklabnik.github.io/jujutsu-tutorial/) and an excellent
    [video from Chris Krycho](https://www.youtube.com/watch?v=2otjrTzRfVk&t=327s).
  - Get started at the [jj GitHub repo](https://github.com/jj-vcs/jj)

## We have coding assistants - so why learn a new tool?

As someone who works on [developer tools](https://boundaryml.com) at
the twilight of humanity's involvement in the software development
process, I've worried about the utility of learning new tools,
writing new languages, or making any bets on human productivity.
Isn't it better to move back to languages and
tools with billions of tokens on the internet for training LLMs, if
LLMs will be writing all the code?

Well, new languages and tools _are_ coming out. And the complete AI
takeover of software engineering is happening over several years,
not several months. So I do still have to write code and collaborate
with people.

There is a trend among my programmer friends: the ones who are
the best at `git` tend to be the most excited about `jj`. **Interesting**.
`git` power users had conquered all `git`'s complexities.
They understood the underlying model, were unbothered the differences
between the commands for creating and deleting branches, knew all the
different and unrelated jobs done by `git checkout`, and had bookmarked
the StackOverflow pages for removing a change from the staging area.

You might think a `git` guru would be the last person who wants to
relinquish all that muscle memory and switch to a new tool and an
new set of commands to memorize for version control. **Nope**. Those
colleagues have had their tastes and sensibilities forged in the crucible
of `git`, and when `jj` arrived, they immediately saw the value and
accepted the switch cost. They fell in love and started making
slide decks and blog posts to try to convince their friends to use
it too.

Some developers (even some great developers!) who don't self-identify
as `git` gurus are likely to ask Claude Code to turn a vibe-coded
work item into a `git` commit - meaning they'll prefer to prompt
"add all the files to git and commit and push it to github", instead
of running `git` manually. It's a wonderful finding that
Claude is trustworthy enough to drive `git` for us, but it's also
an indigtment of the `git` user interface.
